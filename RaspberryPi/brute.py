import random

nums = [1,2,3,4,5,6,7,8,9,10]
difs = []

for i in range(5):
    index1 = random.randint(0, len(nums) - 1)
    index2 = random.randint(0, len(nums) - 1)

    if nums[index1] < nums[index2]:
        difs.append(nums[index2] - nums[index1])
    else:
        difs.append(nums[index1] - nums[index2])
    print([nums[index1], nums[index2]])
    if index1 < index2:
        nums.pop(index2)
        nums.pop(index1 - 1)
    else:
        nums.pop(index1)
        nums.pop(index2 - 1)
    print(nums)

print(difs)