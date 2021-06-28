Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0A3B5F57
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhF1NuO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 09:50:14 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com ([40.107.20.118]:31968
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232057AbhF1NuM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Jun 2021 09:50:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NunkjD4ymFOPrkq5Kidk+PvPpKcRTHJ8KlWaZRTZnf2BMVZI5fxmdVrbQvqsPujfO/7Eg8U6bVrdYPpPUlKG2mTgmBsikFJMoXxPYgsvF+6scmGy2OZxZLee0s8PDjK7ZD6slZ+wSdrB8PmpaKVJdMzc4bT0DUCAgBw5BkwOwbzzXr+uqHd/spyJYJKYxvM9go/4J0A0rHIASNJS73N+8QMiSRoelN1YBeKrbzBzkUcAdspF3qPh/BAuktvldCEYtUG/J5g2KeX4lbUPf3bLs8F1q5Gng3gTYjRRY6VPjob4pPleDPjOEXhTFSQGpk4aByFkrws8WD5pDpyxSBfVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2kIoJx8lvizVdbip6m8KbKJAzotQhI7fCd+vfUKylY=;
 b=B5QcClyj07PVdHHuq5Rz+626mYakbkv6XVOEuMhRIDVzlyWPqRMu1iSN7diIo8gxC4veuqApJtP+tDHvJngG7K2HAc8hsn1OCZgcHrMGkYhTY+jEd6RuFvJH5mkslyIQfeEerk9wCOTj4sgK7n1m/BreBzmlQqr5qiiHLsQOS+hZ2Krkpq7kQE+EUWGX5sngttV9Qw6W0XymrVERWhr8qPdnHv4K5uBBMhmxwBBzGuc/uwCFyUHQaZhl+epOofYGCUK/EMy3TxqHyMa7q0yjiUl4sTxR/aLYLDe0N2laiK3prMHFbv8j1j6M/UzaghCNAS8uIfmInCOWL4VDyV/vBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2kIoJx8lvizVdbip6m8KbKJAzotQhI7fCd+vfUKylY=;
 b=ogZNZeECMdlqfd6NKchruiz2Or57LzaOhIdKybprcLeV8z5Ai/evcLwzemgNgwCSa8ePGn5K0tVb5n3kADNMzKTvP42POIMGGdyDth2WBoTyeKJ81rJ33l5gw4ea1moXY+tCbz7pfqG8L5lW5gUsUXwxygd2O6FSuBVGwV838e0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <4b02188f-b3bd-4e80-5d1c-9ace05f54c1d@hartkopp.net>
From:   Harald Mommer <hmo@opensynergy.com>
Message-ID: <c2e9eb39-bb88-2542-2b3b-bac62c1dd3d2@opensynergy.com>
Date:   Mon, 28 Jun 2021 15:47:41 +0200
In-Reply-To: <4b02188f-b3bd-4e80-5d1c-9ace05f54c1d@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR0202CA0053.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::30) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95124490-2789-4ace-982c-08d93a3b4d65
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3516:
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3516E04531D51E04AFCDC076E5039@HE1PR0402MB3516.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGLzAfD1c9licy0jLjoYdGOnYM8VaS9M6vncUy+AC4Ha7I8bK+ut6mPrgWvor6t3jkT3E4B08EL6nTFPkOD8CiWafz+g5TIZHf84y9bgBPBeEBWByrt+Z7k7c/v6O0PPUU9AwRTbWn/mNme9p8Rfqu9vz0HYcWIm43+5trOfBhaFdThn1/q84NPgeYiP/0ZUxN8GxgcyEyZ+fZv6ZYQKjotX7useuWpKBFWgFqOfnc1olIRcvPMs3OjeH1136GOJWEVpif9ltUEw60KHo/zbyC/y16h5/kwLSMklBetTobC+rMJk8e2YUKQSMum7DJMo56PRt1PWmuFbbz/Lx7Ob3DI1Ih9fb7IJzaCIeZmGPZaoc9ZAcVKRp3zuFB8xDtyeLWx+s7J+4ctHMmj6bToutOzKSdNI6wo++1uSJrDrRfhXaXGWwGQP/xeuJTRgB/4y3CB8tELc9rI8U0rrTOOq4WYy/5lKqt/6cqvwXuJInBFrZz/P0vHgvBXiaN7cAFhj288UyS64Yd/PkQBuRcHJev/OgIEUs547t+wZP90So+REjtAePPv5BEmsAn0M8U8m8SsMPLAUA+kq726hVUdtFYHVcsn/87ilmuffwDlojtmn7sAdUHP+D1Zs1bFFW/+QtAQJVvw3K0NvfykhBiniJt7WSLLoEa5eeYw9NM3PFZaeUb+CKJnAy9AqgxvOi0SLZE28uZ726SJLbAtRq2eT800MjFTMTNTmk+JwxPW+2+GnZgAXyuptyZ94nWd17uVQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39830400003)(83380400001)(966005)(8676002)(478600001)(2906002)(8936002)(186003)(36756003)(31696002)(2616005)(31686004)(316002)(38100700002)(5660300002)(42186006)(66946007)(66556008)(66476007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21sdTdJcUFTNjhsTlZ5K3dJYU02K1RXYWZNT0o3ZlRMTkcrR0NpNjduUDlI?=
 =?utf-8?B?ZStTR0MvNzZhblgyZUFheVJVTDJSSlpBSUF4ODN6VkhTbGJQRkVENkZLeDBN?=
 =?utf-8?B?b3YwdGJYVC9LS2NmbXJjRmNaOFFJS2ZMUmlUWFpnQWZjMjJZWnhQZWlKQlUy?=
 =?utf-8?B?SER6aUhzeFhsNWU2cXA1MFVqZnlGVlpObDEzYm04R1hvNTlTbEdRamRkWkRK?=
 =?utf-8?B?MzEreWV0b0U3TVpmMzVLZjVTSC9WOTI5WTRLMWIyWGRzK2U0Y3Y3WUF2NDJv?=
 =?utf-8?B?eWVZNERGQ3BMRlpZclB4RndZMCtwQmg4VmQrRWR2Z25oMWpSaGhVOVh3UU91?=
 =?utf-8?B?VzhoN0NwTndsQy9vcGtRaHQ0ZUg3MzZ1SHh3cGJHa3N1Y0JNUmF1b0RzYzNt?=
 =?utf-8?B?WDBiSzhpL2F5bVdzMytsaVh1UFg4RktqcnJlcjlrTlJ0dUNFdHBYQ0lnajRj?=
 =?utf-8?B?c3RWQVFTazlqTnAzQzV0L0psZ0Z4UVpGdDNCbG5SblVON3VrMitjanRVZ3gz?=
 =?utf-8?B?Y1NaVGk1UkZYU2xZRnVVZi9SU1hETk9Yb1NSdTViQ2lHdGtMUkdzMTVWcTZh?=
 =?utf-8?B?cG9MYnkvbUYzTkM0bFhIT3RZZkxRSTdzT05hUlBEWUExUEVNSmNoMDZSRk1T?=
 =?utf-8?B?SGpwYnBSV2l5ZTJKeHdRV2czZUYzOTlJY3lFaWJHbEJCU0ViT0JtME9QeFNt?=
 =?utf-8?B?SGtLRitvR0hFZU13K2E3VG1iOEtNV3NCSkRMTXJpajRCdVdLWEEwUENJWTRX?=
 =?utf-8?B?SWtYbnFzMVJsakdNbkEzWGo5TnBmNVp2cTdCcFVqUTZ1UGVYbENKKytPejls?=
 =?utf-8?B?WmxHQXZJRHN4SEZPc08wVnJkMEhhdjJXT2Y2VmdwQVJXNktCZ2RmN1JUL09J?=
 =?utf-8?B?NForY25hVWYyUW01WHNvVTdONElZdDQzWFdBTWQ3SnJObjRTSW9vMWpvNVk0?=
 =?utf-8?B?eEQwbHFYdEpEaUlqVkFUdVJXeTZXTWdSY3dnS2ROK0FoT1hMblZkemlQd0JY?=
 =?utf-8?B?aXJoNHBwMEFrOGFKOFlEaDk2Q0RZRTUwSE1iQU0xYkdzV1JwOUxqNGwwOVQ0?=
 =?utf-8?B?cDN6d1E3N09PRE42cUVvK3Nscy9aVnFQcDNMR3RlZnhFWnJwMWN0N1JJMCtk?=
 =?utf-8?B?VmVnMmZkbXNVRGw1VFNyaHlzUGxIQ1lKSlcvb3dERjdLZzdBUjIzQktPL3lC?=
 =?utf-8?B?RzJ5emdCanQwUXBpalR1eU5WMVlwREppRW81WlFHcmtTN3o5MTFZdHczMWNF?=
 =?utf-8?B?SnpSR2tockFORGR5R1RGU3IwU3ZUUUtRa042WC8vMUxkQWVJNE10QWUreDJn?=
 =?utf-8?B?ckdQMXpMLzVpVHdtQ3FzMnNjZUV1ekUwb2Rzenp0ckovZmpweEU0RlNtSmxG?=
 =?utf-8?B?K0JiQmlFZU9vTVRrb2lrY0hRUEl0RTVCNWZyc05mTHF4RUM5NXNBMVRIQWVm?=
 =?utf-8?B?Qy9yZVowRnEwYnNzT3dyZjhSYXZnMlRRUHNENVdlRmxIQ1BWWEEyMlgvOUU4?=
 =?utf-8?B?SHpJUHo0QnRUTzdldzdZZ2txZFRqTktMYnFmdUo2cUNHS2ZwbXZNbWoweDI3?=
 =?utf-8?B?YVc0VTVaNFhNT2thLzFzaHVZdWlIcXVUd0E4ekpIWHFpL1o2TSs3QkovSTdk?=
 =?utf-8?B?OTJNK0NkNURXeWFXem9MeXdxS3VQRHo0OHRxcndLZ3o1djNrSzFFTlE5L0FX?=
 =?utf-8?B?enZOU1d4cUpsRjNWOW9qWFhUZnFGM3daNm1RV2owSlJUV2NyR0tHTnVEOXZ4?=
 =?utf-8?Q?GHTR2lrve6wTX+JU0EmK+jRPI8TDIKGLkIXlxhl?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95124490-2789-4ace-982c-08d93a3b4d65
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 13:47:42.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4oUtspZ9Ms7e1rROVkvr14GbbM5lkzuYsmYCsdAS/v1KcBYACd47qLJaDcLvSFfhBT4xn3ZTYZroiGIyhLuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3516
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

Am 24.06.21 um 20:45 schrieb Oliver Hartkopp:
>
> What is this 'device application' in the sketch below?
The device application provides the virtio CAN device. It provides a 
virtio CAN device using an existing CAN device (here vcan).
>
>>> Can you sketch a quick block diagram showing guest, host, Virtio 
>>> device,
>>> Virtio driver, etc...
>>
>> I hope this arrives on the list as is been sent and not garbled:
>>
>>       Guest 2                    | Guest3
>> ----------------                | ----------------
>> ! cangen,      !                | ! cangen,      !
>> ! candump,     !                | ! candump,     !
>> ! cansend      !                | ! cansend      !
>> ! using vcan0  !                | ! using can0   !
>> ----------------                | ----------------
>>   ^                              |             ^
>>   !  ---------------------       |             !
>>   !  ! Service process   !       |             !
>>   !  ! in user space     !       |             !
>>   !  ! virtio-can device !       |             !
>>   !  ! forwarding vcan0  !       |             !
>>   !  ---------------------       |             !
>
> Hopefully not this "Service process in user space" ???
The virtio CAN device is the "Service process in user space".
>
> If so, this is a very questionable approach!
>
> To route/forward/manipulate CAN frames between CAN network interfaces
> there is a CAN gateway module 'can-gw' which can be controlled over
> PF_NETLINK.
>
> The can-gw runs super efficient and fast inside kernel space in the
> SOFTIRQ context.
>
> E.g. 22.000 CAN frames/s with 6% sys load on a 2 core i7 from 2012,
> here: https://youtu.be/O3eOjfTl1yk?t=89
>
> Just type cangw from the can-utils to get an impression of the powerful
> options.
>
> You can even calculate E2E CRCs and XOR checksums after doing content
> mods on the fly.
>
>>   ! ^               ^         |             !
>>   !    !               !         |             !
>> --------------------------------------------------
>>   !    !   Device side ! kernel  | Driver side ! kernel
>>   v    v               v         |             v
>> ---------------- -------------- | ----------------
>> ! Device Linux ! ! HV support ! | ! Driver Linux !
>> !    VCan      ! !   module   ! | !  Virtio CAN  !
>> !    vcan0     ! ! on device  ! | !     can0     !
>> !              ! !   side     ! | !              !
>> ---------------- -------------- | ----------------
>>         ^               ^        |        ^
>>         !               !        |        !
>> --------------------------------------------------
>>         !               !                 ! Hypervisor
>>         v               v                 v
>> --------------------------------------------------
>> !                     COQOS-HV                   !
>> --------------------------------------------------
>>
>
> (..)
>
>> can be handled. Need the command line switch anyway now to do 
>> experiments.
>
> Now with cangw ?!? ;-)

No. We cannot do this here with something which already exists like CAN 
GW. We are not talking about user processes running on the same Linux 
instance which want to communicate to each other. This might have been 
the misunderstanding here.

We are talking about two different virtual machines both running 
different OS instances under a hypervisor! And one or two VMs may not 
even run Linux as the OS. The device VM could in a future setup run 
under an RTOS using maybe an AUTOSAR CAN driver as backend which might 
even come from a 3rd party.

In the current setup we have 2 VMs running different instances of Linux 
on the same physical machine under hypervisor control. Only the left VM, 
the device VM has access to any hardware (like a CAN controller). The 
right VM has no direct access to any hardware at all. To be able to send 
and receive frames in the right (driver) VM we have to do something to 
be able to get out to the external world. Currently there exists nothing 
to do this for CAN so we must do the new virtio CAN device which allows 
the access to a (physical) CAN controller via Virtio means.

>
> Regards,
> Oliver
>
Regards
Harald
