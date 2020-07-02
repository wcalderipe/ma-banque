FactoryBot.define do
  factory :account do
    balance { 0 }
    status { Account::PENDING }

    trait :opened do
      status { Account::OPENED }
    end
  end

  # Intetionally doesn't create an account together to enforce
  # dependency clarity in the tests.
  factory :transaction do
    balance { 0 }
    status { Transaction::PENDING }

    trait :credit do
      kind { Transaction::CREDIT }
    end

    trait :debit do
      kind { Transaction::DEBIT }
    end
  end
end
