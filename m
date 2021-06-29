Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4A3B78C6
	for <lists+linux-can@lfdr.de>; Tue, 29 Jun 2021 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhF2Tl6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Jun 2021 15:41:58 -0400
Received: from mail-eopbgr50128.outbound.protection.outlook.com ([40.107.5.128]:4613
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232197AbhF2Tl6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 29 Jun 2021 15:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/XhTvMT33dXch23+BbA0OlFqq8bNTFYTBoMqT+qhTTKP7Y/sDvmtL6aqe551JXfGi3Ht9l/odaQjXunoVUsz4UUcRjA4h6lDFo/mazX80ypZqZUOu0hgMTrwOtwzEcq1fTH0RT0RVtJGexg9GF6onlUKOnRKDGRbvyO3K/XbBsxbXvHmp1IAAleWiuk8xNrtutth7BDaq2qub+iy6o29Dgxu9udtcgVY4A4i5vyNHY8ETzMchMDaDZPn6vQW+HyVNjVTMKCFfIClO/SNRJsKr5c2TYdoL2yXIJe5lrpL7c9w/mT05y9t4vOcxh4/8Ul959aGeSCYJCM/ybyGoL2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2fXzJ/yf/UCxtKKxJR1EWjVcSGO+iQLOyw4V+JeXWA=;
 b=H0Av8rIt23MeOy0eBvYSSpfg+mGSyIAISPhgPzpikWDz8s56FmYoTiLVof6yrdcKvbHmZlvuvkihUzC19rJCahQFYJBTK1BAMiWCijZJN9AVX0T8YuYydjGYZg+h94PJsLZnwuXgDLMoNI1XLtjYCJwUhptpmEiwHRfRbIFiOaqoU6ETWLfw4IbaWpr6AojNMsevlLaZC0hnhAD02aHgg8emRhRiorXVxYUo5/Bqkx/9Q0P9zYA9UG5hyLU6rKk9p2E0b/e4z4fyoxpWz07UIbLJ6gVVCZ0nfBfN7SpvR9HYNGRk6jaxinMit5LeIkrM6igIAY52SodI+vERgCuZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2fXzJ/yf/UCxtKKxJR1EWjVcSGO+iQLOyw4V+JeXWA=;
 b=PHcI3gXO4fVrXJVGD0wiw0SV/qDUrXiMi0Pesj5OKheLk7i36bhz1NFf19/93aieaF1IAZ5EoA9Q9uyK4j16pB7U01MJwl1CPkcy9gaL6GX87DtjmoS/I/zG5pbYy7+7sijYKNqAE06hd1kWcN1oykP9yLdOw4rQhPTJIi9VOLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=opensynergy.com;
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
From:   Harald Mommer <hmo@opensynergy.com>
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
Message-ID: <eb9a1f75-3bc9-aa07-9508-6a081be6a15c@opensynergy.com>
Date:   Tue, 29 Jun 2021 21:39:25 +0200
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0009.eurprd03.prod.outlook.com
 (2603:10a6:205:2::22) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e814ce-f867-433d-0173-08d93b359b26
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3369BB4AD7D23F8DE26E2F32E5029@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6ZBhqzJ9qGK0ik9Mf4+0Si+/lLamz42dLD+/jumHMmNqruonGuI4W03XuS19/i96UxSVVTZ98XJSZTtRXfR7pcWCl7m+pwdgwvAkbVbAvGhpfLL86GR86tNiEDEZ57qhZN1DdRH9ySKJNOcqwkdA1bewXaB51c29wOWA6Ciuu7FT8u+5s7P3rAAtNoeFTuTKFU9Eu2frzk4TLExZa/CpQpQnM1xDFa31Ob1PtOOQOWrYuSdiUzDZgk7RGlpTUPQRenh2UAnrL81g1Iqt2nJ8C0qPTPZj2PgiI014zot0POnr69DYk8R+4xE2QaV/Rgdtpb2PI8pMIEnYLnXgabKUAEFpXE9UonoLRAu4R95v6t/0Q8WArU48uaJbTbSglnbNhfLSjM0Os/rx3Pge2SLcl7Y7E9M1VymFuYaqCORkJkjJzcXGvIus0Pa/sN83HfzU0hrXIUCtHq/qRZIRENlk4vAWtcoz+Em0SURlQ4Hc4vjXEnni16NeEGf2GMtuYsIdM3kVs3KHcMVRoyufDOKlWLR7ls/63LXd843QrsISebS+K0FdmYoEORF5PLuYxP5KDHpWILmCvNBq4BNJ2zEpf9ZNmZ03w8h2GzxCvwVDRHZ1arRYQVS+AR9EJ/UVpIbKYYMMqFPRiz6/cLncHQC+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39830400003)(2616005)(66946007)(66476007)(186003)(31696002)(4326008)(2906002)(42186006)(316002)(478600001)(26005)(83380400001)(5660300002)(66556008)(31686004)(38100700002)(110136005)(8676002)(8936002)(15650500001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpOa20rRXVDVFZUcTRDVXFlNzZWTXlDRlhSMXpKODFXdjl5WjR4cWZSTUxh?=
 =?utf-8?B?bG4vNmliMDEzekQwS3J2RFFxMjF5aFNYUUhtam55b1JiV0xZOTlNa3hkdlEx?=
 =?utf-8?B?Smd1UCs3cUFpcitpTCtvSG95cjFZUFIrdHlvZnNYd1FoTUkydGt5RURCVVRl?=
 =?utf-8?B?M25veWFOK0oxYWZ4WUFQaSt5L0lsZ3NFMmxSYzNVUE9VV1I1QXltaWtBRVNQ?=
 =?utf-8?B?UFdOUDVZcjNQamkrbHRuWGdHVlBvMDJaRGZBcURIL0VDMW9EbjBwaGhMb2d5?=
 =?utf-8?B?TnNybGYrVW9rdU52U3ZXOWFiZmdyMUhaeEJhOEY2WGNDQ2FvbE8wdndpbHJT?=
 =?utf-8?B?em53eGZKSDZ6NkhWZGxZZnFCelJBRkpZOG5qRStmd3FoUnUvRDI0djYrSTRx?=
 =?utf-8?B?QmREREQvZCtyazMrZTM1QjB4d1ZiY0wzeWFPZFc4SmJDOGRUUkF5Nk54UWo4?=
 =?utf-8?B?QisrRWFUOTlPVk9ZQXhTdm91WStaMXBzMWl6SG9vU2h2OUUwM014OVZiV1NO?=
 =?utf-8?B?dHVCSklLaFdnNWZtb1NaQ1o4bnNiRFFVZXJOVTFjNlB6dkpFOUpIa0hlQVJi?=
 =?utf-8?B?YVM1V2dqZnRNTld6M21EZllIQ3hOWjRhRzhKemd6QUlhRWQzdWp0bUk1TCtT?=
 =?utf-8?B?b1FmWXpYWE0rK2Jqd2ZZWmREeVZObGN1WWFpMElIRk1uSUpaaVFCTEE5SEQx?=
 =?utf-8?B?blY3ZEIvdHByM2MwWVg2T0ZuMWl5VEtnM1RWaFYwSU9rbk9DdWQra0J0c1Jj?=
 =?utf-8?B?M2QvQmJhOHYzTTFnMTJtNjVnQmZmWDR5MlFZYml4bDNnTlpzV3EwaURXVFBj?=
 =?utf-8?B?RFNycU9LNEI2SXVFQzNjTm1VOGVhMUxRUnRpTW5Lb3U1TGY3SDJWcDIyWkkx?=
 =?utf-8?B?YlEzNzVtd0xPbWV3OEVUTjhBODc3cTNyeXUyU3UzSTVVYnpJRTVPeEllNER4?=
 =?utf-8?B?OTR1bmgvZ3poTmhXblY0T3QzM0QyVXJ4MlBWcXpONlpjYk9obTFGWlMvS212?=
 =?utf-8?B?bGNvQ2huQVQ1Nk8rNDJmSTcxK1FnSURSSjFVUGsrWFYwQitqMnpQc3RSaEVp?=
 =?utf-8?B?cmI3NFR2NWxQUjQ3Ym1DbDN3amVFLzd5YWVaZ2F2R1k0dXk3OCsvUnFHdThl?=
 =?utf-8?B?Umh3YjlWVERyZjRwaVZpd1dYU1F3bERsWEFNaGdqM3lkY3R1VTY5U3FKKytt?=
 =?utf-8?B?MHMvNkRlN3BKYkh3OGpvUG1EcDVNNndNVmVRaDZqYUZzQzJyTDIxOWJjcVBU?=
 =?utf-8?B?bDhrWWNNb2NFeG1tMzNSNGZnVHd3OFFpMWExditqRVM3ejI0eTFEN1gwVUll?=
 =?utf-8?B?VFNjcXgwT1Z3RUZXYUUycEVkVU4wMkV0czlQenloYXVEY0VIOEdYekN6UDVV?=
 =?utf-8?B?Sk9LOGpkajJ4U1p3OCs3WmZqUGh5enRrdzAva1VpUVlIZ0RXSnQzQ2ord0F3?=
 =?utf-8?B?T2wxUklZNlVtNzNMY2NseDc5aXFUQkFjczJSMVA0MnhZZ2ZSdHUvTmo5THBa?=
 =?utf-8?B?OUIweGd5OHgyOUsrZlFINkdrVnZuV2R0OWxtcTN0VVZEZGtsN200MlRPS0t6?=
 =?utf-8?B?Ulc3RHRvbVc3MkJUN3B6QlRTNWNjN1RKQjdTMWlNbVYvTmJWSFJna3JmQ200?=
 =?utf-8?B?dHZUd3ZXR2Y1UWVCYVo2MFlOT0dVM0ZoQ0k4VERyS2orVFlkT25sNHlFUG15?=
 =?utf-8?B?MnNvanJBSjNXNzB1TEROQ3ppSVc5d2IvU1BUcUNiVmd2bll5VURjZ3pLZlNH?=
 =?utf-8?Q?ZArrF6KbU1gPNam6GTE/veuaLnAbM9HGN34uiSm?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e814ce-f867-433d-0173-08d93b359b26
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 19:39:27.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzppC7cemJQ1OSY3NCuF528oZae+crT+ZyC36TK0YxZ6PFKOplSquNueUKJYigQvu49nDhimChrD/5jC7mniiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

[Re-sent because some mechanism on the mailing list thought this was 
SPAM and rejected.
Looks like the list does not like when Thunderbird composes a HTML 
E-Mail. Setting changed & retry.]

Hello,

Am 25.06.21 um 11:39 schrieb Marc Kleine-Budde:
> It makes sense to have a TX done notification. You probably need this
> for proper queue handling and throttling.
Yes. But this acknowledgements must be 100% reliable under all possible 
load conditions otherwise testers will prove that the solution does only 
work when the sun is shining but not during bad weather.
>
>>> Can you sketch a quick block diagram showing guest, host, Virtio device,
>>> Virtio driver, etc...
>> I hope this arrives on the list as is been sent and not garbled:
>>
>>       Guest 2                    | Guest3
>> ----------------                | ----------------
>> ! cangen,      !                | ! cangen,      !
>> ! candump,     !                | ! candump,     !
>> ! cansend      !                | ! cansend      !
>> ! using vcan0  !                | ! using can0   !
>> ----------------                | ----------------
>>   ^                              |             ^
>>   !  ---------------------       |             !
>>   !  ! Service process   !       |             !
>>   !  ! in user space     !       |             !
> Oliver has already commented on this :) Getting feedback from the
> community early could have saved you some work :)

I still don't get it. This service process is the virtio device itself. 
All our virtio devices are user land processes. There is no problem, 
this works that way.

The problem may be that the virtio device should better not have used 
vcan0 to get CAN access and that it should have used something different 
instead. CAN GW? Is it that what you want to tell me all the time? "Do 
not use vcan0 to exchange CAN messages but use CAN GW"? In this case in 
the picture the box "Device Linux / VCAN / vcan0" changes but not the 
userland virtio CAN device service process box.

If it's this I'll get into CAN GW to understand what all this means now 
and how to use it.

But anyway, if so this should not have any impact on the driver or the 
spec, this would be an issue of the device implementation itself which 
is closed source and should now not be this interesting.

>>   !  ! virtio-can device !       |             !
>>   !  ! forwarding vcan0  !       |             !
>>   !  ---------------------       |             !
>>   !    ^               ^         |             !
>>   !    !               !         |             !
>> --------------------------------------------------
>>   !    !   Device side ! kernel  | Driver side ! kernel
>>   v    v               v         |             v
>> ---------------- -------------- | ----------------
>> ! Device Linux ! ! HV support ! | ! Driver Linux !
>> !    VCan      ! !   module   ! | !  Virtio CAN  !
>> !    vcan0     ! ! on device  ! | !     can0     !
>> !              ! !   side     ! | !              !
>> ---------------- -------------- | ----------------
>>         ^               ^        |        ^
>>         !               !        |        !
>> --------------------------------------------------
>>         !               !                 ! Hypervisor
>>         v               v                 v
>> --------------------------------------------------
>> !                     COQOS-HV                   !
>> --------------------------------------------------
>>
>>
> IC - as I'm not interested in closed source solution I'd focus on the
> qemu use case. Good thing is, the virtio-can must handle both use cases
> anyways.
For me qemu is in this moment an unknown environment to develop for. 
There are already some challenges in this project and at some point 
there are too much challenges. Have to discuss if/how qemu is to be 
addressed.
> Your user space bridge is the wrong solution here.....See Oliver's mail.
The virtio devices are always user land processes in our architecture. 
Only what exactly is to be bridged is the question.
>> Nothing which should be done now, getting far too complicated for a 1st shot
>> to implement a Virtio CAN device.
>>
>>> We don't have a feature flag to query if the Linux driver support proper
>>> CAN echo on TX complete notification.
>> Not so nice. But the device integrator should know which backend is used and
>> having a command line option for the device application the issue can be
>> handled. Need the command line switch anyway now to do experiments.
> If needed we can add flags to the CAN drivers so that they are
> introspectable, maybe via the ethtool interface.
I understand here that nothing is etched in stone for all time. Did not 
expect that something like this could be possible.
> Marc

Harald


