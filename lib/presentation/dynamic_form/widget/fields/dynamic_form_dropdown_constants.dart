const int kDynamicFormDropdownSearchThreshold = 5;

bool dynamicFormDropdownNeedsSearch(int optionCount) =>
    optionCount > kDynamicFormDropdownSearchThreshold;
