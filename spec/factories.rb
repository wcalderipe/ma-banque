FactoryBot.define do
  factory :account, class: Banking::Account do
    balance { 0 }
    status { Banking::Account::PENDING }

    trait :pending do
      status { Banking::Account::PENDING }
    end

    trait :opened do
      status { Banking::Account::OPENED }
    end
  end

  # Intetionally doesn't create an account together to enforce
  # dependency clarity in the tests.
  factory :transaction, class: Banking::Transaction do
    amount { 0 }
    status { Banking::Transaction::PENDING }

    trait :credit do
      kind { Banking::Transaction::CREDIT }
    end

    trait :debit do
      kind { Banking::Transaction::DEBIT }
    end
  end
end
