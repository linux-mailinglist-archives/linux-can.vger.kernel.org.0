Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D932CC141
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgLBPsk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 10:48:40 -0500
Received: from mail-eopbgr50116.outbound.protection.outlook.com ([40.107.5.116]:25245
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727677AbgLBPsk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Dec 2020 10:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efcf74TgoZgbSIwnU8b6ENwnXMgac+UKQQul2xLxc9vdRS9pFr4CS0cIhZMia9ZxjcA5tyaBGVHSa8sYDYCKzh3C/XZ5EekWhyyItSvBZhqU3kVlqLkL+heFSH1wYSJchFyuvtd/+3AgBDLHAHEAz8KHc47CDmfAoJtz7Cz1MiXHgk+rG4AeX8kj8c+geZtRckhOXSg+HOkCnwRiVHRd3eTpUBNlCRhi/Q9eUCpPgiIIT2+lQ1zvZdgixraOlcS3TKKcEeqEwKwsQvVTRZlUn7p3kjotwVo44QFgBbay78Ided03jFnTQ8yLJL4bYqHY2eXPs4iks00ZeCgOkbD8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYJk55MvKJlbRBsluiiCe4BLROvZ1yjrqLDvqHGnwAI=;
 b=P+LGzd7XzQQwq2jjSho2xHT0ohnyPF+mvhFlcmM0Tn1s70KEOjQ1qA2r/sLv0n5DaAgTvHm6PbeKJ3S8tsVqgY/HN9znYdvL7muuT83eb0bp3qbbe5w+ppvyaMe9UlwH+W7lx60mwJsAdkhuisV+Nw5t4uHfHOmnZG45JBtrbv9f0KA6mIIy1ZarlPiUnY6zPyoFnQwlrCgZFepS3vSDRVbmKI4IEmfGaD2N45KhfrMOIgbaCudmaEhVfRn0mqZNvkrsK6FPTS12OWjN7uZtS4FUtvJQQpuIOQ+a5vKSulD2Q5gmLw1aGeMsMcrnX2Eu5jqze81h0Edf/UUg7nGBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYJk55MvKJlbRBsluiiCe4BLROvZ1yjrqLDvqHGnwAI=;
 b=j6AfHGT86INdjcy2+LtVL5nbcWFn+MXVESo/KNhXwnp9DcRNW5UwLgLDLJHh0a5C7rGdR5ee/tVwMpBc7OsnDzTwOaLYXRq8fGFcbMCw0UJSHOLVuoC9xZvp8u5ZAA46eeDOscKAEJ0SklGrfwDi06Kw+UsUvy2+IqahlCYHc+M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=victronenergy.com;
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com (2603:10a6:10:192::11)
 by DBAPR07MB6854.eurprd07.prod.outlook.com (2603:10a6:10:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Wed, 2 Dec
 2020 15:47:51 +0000
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c]) by DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c%3]) with mapi id 15.20.3632.009; Wed, 2 Dec 2020
 15:47:51 +0000
Subject: Re: rx-dropped increases if the can module is not loaded (yet)
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <269cc265-272e-6b57-0f95-90a3bd66aea3@victronenergy.com>
 <438db92e-692a-5fcf-db97-7ba3a51c97be@hartkopp.net>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
Message-ID: <dea3d0e6-9e75-671c-b318-830b080ce5d5@victronenergy.com>
Date:   Wed, 2 Dec 2020 16:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <438db92e-692a-5fcf-db97-7ba3a51c97be@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2001:1c01:3bc5:4e00:e791:efe6:bf00:7133]
X-ClientProxiedBy: AM4PR0701CA0013.eurprd07.prod.outlook.com
 (2603:10a6:200:42::23) To DBAPR07MB6967.eurprd07.prod.outlook.com
 (2603:10a6:10:192::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:1c01:3bc5:4e00:e791:efe6:bf00:7133] (2001:1c01:3bc5:4e00:e791:efe6:bf00:7133) by AM4PR0701CA0013.eurprd07.prod.outlook.com (2603:10a6:200:42::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Wed, 2 Dec 2020 15:47:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debda649-7749-4df6-a567-08d896d9a067
X-MS-TrafficTypeDiagnostic: DBAPR07MB6854:
X-Microsoft-Antispam-PRVS: <DBAPR07MB685495CA9DBFC386C20AFC38C0F30@DBAPR07MB6854.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLDOaWSNO2HlapI9diOSFF7sTm9T/tuqMCFfAbuEoQjhdFUHsQkNJ4/Yww6yKQWD2FRlTYjd7Ep5BwC5a8ZAffd/zRHQuPwvEmaR7mqJP2+DxUGE/4OeQmByywgnAlobZPrycxBpKspxVcOvAU/3JAly+MkWw7hqVvYPbjUyLrrN3eZUCBXiscHKb8iXGwsk+Y/Z4dMgUOB7yjWH6gxHrOehik8WyE0vZem8V3Wibihmvtauk2woXLN73TQDx7YT+AgbbC88CYIrsb66lHT8hmIcQy8wd9okdrn0g8qUymptkvsTUGysUMd/4HKvGF4SmF2VpOTFYfLXsNICK33+y1tfVBQ1hK27MjGC54WIRHbIZo4w94zKDFQ41Ix1L4VvYLdsfGvEps5YjQCUOnhUOoqxY/ftU60cLz6d4G/u8o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB6967.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(31686004)(4744005)(186003)(16526019)(36756003)(8936002)(53546011)(478600001)(8676002)(86362001)(31696002)(66476007)(2616005)(66556008)(66946007)(316002)(110136005)(83380400001)(2906002)(6486002)(52116002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGIxeXF1SjhRSEtjYkd6VWh6VWQzeG5tZ1p2dlBzclo4ejVnUFdXU0pSUElE?=
 =?utf-8?B?UlRDd3JvOG4yYVRPMDVhbU5nSE80cGRxcVp1cHZzaFY4RHVOUmNkTkJoVEtk?=
 =?utf-8?B?VmpWc29wQ2hMcFpkQ1JmLzNkczRYQ08xT2lGZkNCckdhRnNwYmdVN2tBVUVX?=
 =?utf-8?B?YVVPU3lwTlNxMUp4WWZDcHpBdGc3UGEvVThkZzF5c2RITDgxdDZsRjMxK1cr?=
 =?utf-8?B?U2dFNmd0NktwZWpmbzFFUjdDWE1TTnBCZWlIUFhnQjNBZ3pMSTQ1d0Z3WjJW?=
 =?utf-8?B?d1JINTc1SFNhaFpNQUVyL3lJRHJqYlVRV1cvRkt5WDJ3UzZGRDRRTVZ4NkNZ?=
 =?utf-8?B?SnBkVmx6VzJWbWdRbW5pUkRYZkUxZEpaTS9SbmtubGhTai9HdXZsVE9kZTdj?=
 =?utf-8?B?eDVaRnFtb2RLSzVOczM4a2dGY1pQZDU5SHg4RDJwNVBtZ3h6b0xkK1grYVMv?=
 =?utf-8?B?KzdFbEl2YmZ0ak8wcWtJM0tBRnNLOVVqSTFIOTFlTUhzMmVFaklYWGVrUml2?=
 =?utf-8?B?dHljYnJCNmtySzFwcGVDYVdYNHhvbTFOZUhFSnBLR1dCZlNSZDBuKzNQMXhx?=
 =?utf-8?B?dW5tU3Fwc1Q5OWZkUGl2d1c2UHd2Ry9GakpBTGVBaWxSMFczN3RCaFFTeENK?=
 =?utf-8?B?anlEeENYOHlRN1ZqeXNpakVYY1R4QlptMUFBRDRhRnBZTXl4bVJrZjQrQWFV?=
 =?utf-8?B?bkRFd2F5K1FBQzdjTkdqTTVrU3JFQ3Vzb1ZUd1BmZVo0dUVxYlF3ZUtudkVV?=
 =?utf-8?B?VEVZTlNNQ3RMdmlMSTV2bnY0ekE3YlRIWXVxT2pIcURwVlREZkR0SFBCQTE3?=
 =?utf-8?B?R2dRWkVqTEFhcGE0SnZQTE0xdy9XaFpWUTcvemR5R2dUdDlVWjNwLytEY3oz?=
 =?utf-8?B?L2lBZTRQem13cVZoTnBhbFBPV2hIbEJnbXU3K1NKUzc2YVIyNGxTN2ZqTWJr?=
 =?utf-8?B?WFU5V0MzKzR4ODFSMDFQV1FIb0d3QnB2d3JxRjFGUVV6Ynd2dkVCbURYRmk4?=
 =?utf-8?B?dXZaNWJlWDcxazh4aWhoOG5CN2hrQUltdWZhYUVjNFpBRnJkYXVlZEI4L2pZ?=
 =?utf-8?B?RVpiSWdXYkVvM0o3NjZZNEZJbjVwbWtmKzVaN0djK1VETmVKWStxWkw5SElo?=
 =?utf-8?B?TzJDb3B3dExMNEVEa1lwdmVyNnIzdnBzRTVaUC9OUCtIR3dWZnpxcmRwWmtw?=
 =?utf-8?B?MSttUUc4eHhlNUNMSjFPNk1Kc1htbXB1WkZEandGQStMRnFuK1Z1cXgyNXNu?=
 =?utf-8?B?V3J4QXNncW8vY0JrUFpNTGhOWnQ0YXVkbmxtRjh2bXFvdEd6akZVSU9EOU5q?=
 =?utf-8?B?N2pqZXVCNUJrUVA3cnltR2VmZXNRZGJKLzYzekJzNFdGRWJvYUFXaUN0bHJD?=
 =?utf-8?B?dVprTDRHaGRXdnloZmVXTlNWSkhrRC96OFcvaVNpbXVLU2VQTDdPcFdNMjJB?=
 =?utf-8?Q?XEEjCKjP?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB6967.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 15:47:51.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-Network-Message-Id: debda649-7749-4df6-a567-08d896d9a067
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beQPaipLIcOnfGWI2Y4dapj+x8QDFvmSCKJ5ZVVRrpofund14lQnOTfuNKxZ1MTFQjOZDLGbq9t7w9MW0Z/7bJZ3t+lugF0zrxt7JBk/Jbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6854
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

On 11/28/20 6:44 PM, Oliver Hartkopp wrote:
> On 27.11.20 17:09, Jeroen Hofstee wrote:
>
>> Since it took me a while to figure it out, it might be worthwhile to 
>> share.
>> If a CAN-bus network interface is first set to up and only later used,
>> the messages received in the meantime are counted by [1] as dropped.
>
> Interesting! But makes sense and is consistent: When the CAN frame is 
> not processed by the network layer is is just dropped in the rx path.
>
>> If the the can module is modprobed before the interface is upped, this
>> is no longer the case.
>>
>> Perhaps it saves someone some time.
>
> So far we have not documented these details for the existing netdev 
> statistics. Do you think this is needed when the behaviour, which 
> leads to rx-dropped, is common for other netdevs also?
>
>

Don't know... Perhaps we should simply wait and see how many
people show up wondering where the rx-dropped frames are
coming from?

Regards,

Jeroen

