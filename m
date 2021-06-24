Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0C3B326E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXPXk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 11:23:40 -0400
Received: from mail-eopbgr60136.outbound.protection.outlook.com ([40.107.6.136]:12069
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230008AbhFXPXj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 24 Jun 2021 11:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpLLRzz4oXwwGq5aEwHYfGek9KaOR20++PYDv+PuU5OKv/zPHO52Bu+7vOxbSTYLY1zhS8Of71WMc6osf9zlOqS9620I59Ys9WTIiKmX7yrByKKocl0nL6+aOIpEGeEjuzTOx/9b7lWVQqGlME/9HlYOfbldyqrcOGwQqQ2kIt1z4r75sXR+vaSTrpBJDjyKPDJ8Ti119GyKGmwGaCjPT7jgI6f0GkZlnID9mPSTdPa1UhMgKDb8us1UNvqmiAqIMSJHS0t0TVUqUYS5XVJVszsAvEe/nzecYPaWpu225Kv3zaRVm63rmm9ukfhkNJdqT1RkQNWLE14TZkDduI4odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4oO8hXFCJtR/20NHPTBeZ2UmRcQJEXT0K+RKiGHtTQ=;
 b=QGNFQwIBmNsPOiVby3QdKts3SazU1t8IoATjbTYIPEKcJqZx05d02FFUULkDGHOq870pn4u3EzUlCJFW9dKL3pxxrjOHN3WQC1PPuS85dLBRzISjdborwwF/uPADfY6VGKbe5d+B73mXs3B2vbx5+us3/XaIqWePAE2duEvjjzLDmQO4BEmPZfXfxM5/ieCwJSZGH0XYFlVyKqFLrIQc2FJHY02yCV3U1yVgzUg6ETQpoMh8YdAEsMZZAT5a4A6eISG3/tYY4HI5Ffw8zvvjEF7I1Y9aEHb9GJM1nwI/pbjTh9Xcd+4IQrAuEnjOZfWrUoV7WQcA175pMJ26VhOGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4oO8hXFCJtR/20NHPTBeZ2UmRcQJEXT0K+RKiGHtTQ=;
 b=tFQXfTF+WQt93cJrdc4vypiLVgu8TzE6/oOWBvTXbD2LCAaZZRTAGMVpy91J9qu2oyp0np91YtrxL04jPUdo7UUqY56NhpQVVDoA/1JSMtYqi7uo57rSZQRS7/ioPD5kddbkfE/qfqlETTr1cYaEjCPkoKv7BqHERFPchJQZftc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=opensynergy.com;
From:   Harald Mommer <hmo@opensynergy.com>
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
To:     linux-can@vger.kernel.org
Message-ID: <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
Date:   Thu, 24 Jun 2021 17:21:15 +0200
In-Reply-To: <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d801a07d-81da-4536-7a54-08d93723b614
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2553:
X-Microsoft-Antispam-PRVS: <HE1PR0401MB25533188302A642D4FF76E0AE5079@HE1PR0401MB2553.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ6SwnQ2C38TyR7PLVORbao3Hzpr9LEZ5fgl41gs1zCAe26HLRwQyQbJatSpEVIyOZ0t+i1Xw8+VPd5Rza17QA/wlRUQu6TDzX1wpvYOhq47GtB/T/1dXNJbiuOWFj6k4cVdubMc4UlPyyqDLsSkM0/4UffFIwKKoIUrY9MK9trG3qVQ8zMIY7VCCtvPEzzlJUec51NLbjbO4GkDexyL9FC9O+3DmnaBhU+XFJoZlWNZUxThXZ1YK5pSnW56tekMgW0ah+mJOCSWqKiLwLglHCH8IQzn2UVVtV2rOSwxhUfpjBP//SRsuEUxO9i710L67TB0wj6v5+jKYVoV2L0WZygtgCN+BId8Hn8RKQMJJFVzpRl/Cj1Rt9KaUKLqwK6XFTLxO44nTrVFi+PeQhXIzuT8btIFMy1IbEpsPFjhNTar/huYaSdMzAhrNjfRx9F0Ji6BMeIJLEjZJaJnM3/Q7AeJ4Dbtd62TbYPksVkwamql2d1T+Yk3IAbo1CF2ZTdm+xZIoABf2vXbwGu0tuHrN4NUNjpZYnNalyXzGjdBOFfKU0fr++hJyTyr0lotta0TB9IkZa0lMms8A9aL9ZFRLBmYhTBdR9CRWTOabb7gU81BEt/Y3yt7FgqNTLuKZz/BicA2J8xBEkbpNoGhIeNxtGmT5FBm/Z11UwcS94Dv+DXOTf+B+XKIiAbwzaQj/19Brdcetlm0LN/T6s34kAVi5xG8069Yt+KJWX1UF2J5bMopVPMn4I7tiOUBIIYiPZFj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39830400003)(2616005)(15974865002)(66556008)(15650500001)(36756003)(42186006)(316002)(66574015)(83380400001)(38100700002)(8676002)(8936002)(31686004)(186003)(31696002)(53546011)(5660300002)(26005)(2906002)(66946007)(966005)(478600001)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWNJUDEwRExsUEdjWDg4QWtnYnN0a1hZdjRSSFhhRFVjVExpVStzcU9PbXkx?=
 =?utf-8?B?eXB0eWNmRWpYL0hVNGNBSmY1TzRVUStpYThYZ1dmRFdUaDhxWHg4TFJwWS9p?=
 =?utf-8?B?U29DTWFVR0ZVd21Pc0Q5enY4NU4xcXhaVXBiTzA2VS92RzVNb3cxSDN3Vk9Q?=
 =?utf-8?B?V29WenVDSXBYMElqUlR2RUkrVUxJbnVFakNDRzZScTk5dmlOV2t6M2FwdG9D?=
 =?utf-8?B?REVXSUhSYlNuclNUZC9BTlhkNytUQWl6NnhRdHRVbVQ5Z3RzZSsyY3F3OUpB?=
 =?utf-8?B?cER5S3lBZjBtdUpNY01hRnlSb2YxOWlTYXpLOXg5eWNxRGY3V096cGhtSWxR?=
 =?utf-8?B?Nml2MGZCK1ZHTkNCenVSS2EyTzAxajRYcS81UU9VRW9UcU04eG1TVTc1bDFo?=
 =?utf-8?B?OWpVNUhkQURpWG5mNTdMMklHa2N5ZjVKczBOK0lBdXJGTmQ3bDl4L0dUYlQw?=
 =?utf-8?B?ZnVYcUVvNHgvYlFUQ1RoZWQ4SzNibnRBZ0tGRzFhSmhyN25TdEJzL2ttVUdE?=
 =?utf-8?B?WWxKdUloM0g4dVdhdzh1ZURIZGg5dytrdldiQmFGL2loUjk0bE5HQUs1aGI4?=
 =?utf-8?B?UUtMNkJEZksvRWgwZ3MzclorV0daZ0FKYVMrc05jWGZiTnFWbUdZSkJ5Y2JY?=
 =?utf-8?B?VXkxWkhDTUp6c3hPK25rTmtuMlY3aU5uWU9KU2c2RHp3d0JtUlpkaGFTUTZ0?=
 =?utf-8?B?bTRBUVdJZnBPQXF6R2FnU25iZHREZ2tQUU5WYm8zRWVmQ2hnWmVxQ1IwUjl4?=
 =?utf-8?B?dCsrOStmWC9QaGw2MENkL1EyZzlBNUVHUU05aGRpdEpUTDkrK2FzK1lqWFhS?=
 =?utf-8?B?OUpQOFRUV3JuNzAxWGpwY0RxLzh4QlpnbEI3OVFlaXM0b04rcFNDZVlzaDBp?=
 =?utf-8?B?NDhld3BTS1pWbE5vWHdpR2psSWNtYm1QUDI3bW50M3lxU0R0WlJKWjBNUzY5?=
 =?utf-8?B?eXFaazJhZGtKV1FCUjQ5Q0Z2b09JK0ZiWGJnWWcwR2VnOGhEd0VpbW9wdWxV?=
 =?utf-8?B?dUhuMGVLVnF2UFBsTWlWMGRIWVhwekRGMk1EMU5OOWRNUDhQTlBUM1FwZ0ZR?=
 =?utf-8?B?dlBObkVZWnBoUDAyazdnQ1pkc3llaDM1MkJzdnNhSkNVTVBEKzJYQ1RscWVj?=
 =?utf-8?B?UjBKaFlnazVUV01WN2QrTURiME1qeW5WMW42MjJJMVZMN1gwREdEQTA3MU1y?=
 =?utf-8?B?UkRDWnNEK0lDVzJKL1VhTkRwbi92YUtDOGg3aFZtT3N1aWtRTkQrNm1vYnRT?=
 =?utf-8?B?czVpZ3BvdHAyN2lKUW5SbDVsR1ZpUitzbFFPeEg3RFlFMk8yQVRqKzFjdVFa?=
 =?utf-8?B?YVpiM1FxZ1ZYUGI2OU1qN09sM2VGYm9vaUxOTWNrbVU5elh4Q0pENUNEZ3Nt?=
 =?utf-8?B?ZjAzM1FkN0tCaVpjaDV4TnVhNi9nTXNSRTFmMEZyNEQwdHF5bU94K0YwcDVk?=
 =?utf-8?B?RWZ5ZWZyMjBiVEdOTWljL2wzL2VGTlAzMTgxeUN2SVNsWDMweFdoSnhWZWpJ?=
 =?utf-8?B?am9sV3JwOG1SZmZHS2wvYUFMR1BDZGRNR1MrbjhCUmNLcjg1ZU9jMmxFVHBZ?=
 =?utf-8?B?R3BRMkp3VmU0amNhYTB5ckpCS2hxL3VvUXd6d0ZaM1A5M2xWdENrc0dOWk5D?=
 =?utf-8?B?VXArdVVSNXdNZmJkczdNTTF6US90ODR0NEJaamJMK0RLWEt6ZDRRWWVLZFI4?=
 =?utf-8?B?Ty9kSElFM1ozbithbXljaXIxaXdiTjVIVkZhaEZYQTVRZTFUcVJzUC9OUDg5?=
 =?utf-8?Q?TbXKJU2UKBi3Ux+oHSN7ej6CckJpzta+C+K/plF?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d801a07d-81da-4536-7a54-08d93723b614
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 15:21:16.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btBgrYTrJCeunkLAl/cZdUhd6PmisvK5tNe0p91iOQtYne/MDhh+QGeM6cfcUqO+Vdr1qHKuyDs3bzELoPb/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2553
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Am 18.06.21 um 11:16 schrieb Marc Kleine-Budde:
> On 17.06.2021 14:22:03, Harald Mommer wrote:
>> we are currently in the process of developing a draft specification for
>> Virtio CAN. In the scope of this work I am developing a Virtio CAN Linux
>> driver and a Virtio CAN Linux device
> Oh that sounds interesting. Please keep the linux-can mailing list in
> the loop. Do you have a first draft version for review, yet?

First draft went to virtio-comment@lists.oasis-open.org and 
virtio-dev@lists.oasis-open.org.

https://markmail.org/search/?q=virtio-can&q=list%3Aorg.oasis-open.lists.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-comment+page:1+mid:hdxj35fsthypllkt+state:results

Link should reveal the short conversation. Currently working on the next 
draft which incorporates the review comments I got so far but the next 
draft will also address the "TX ACK" problem we are discussing here.

In the future I will put the Linux-CAN list in the loop.

>> running on top of our hypervisor solution.
>>
>> The Virtio CAN Linux device forwards an existing SocketCAN CAN device
>> (currently vcan) via Virtio to the Virtio driver guest so that the virtual
>> driver guest can send and receive CAN frames via SocketCAN.
>>
>> What was originally planned (probably with too much AUTOSAR CAN driver
>> semantics in my head and too few SocketCAN knowledge) is to mark a
>> transmission request as used (done) when it's sent finally on the CAN bus
>> (vs. when it's given to SocketCAN not really done but still pending
>> somewhere in the protocol stack).
> Makes sense.

Reading the "Makes sense". But reading also the rest of the E-Mail (and 
the thread) it makes the impression that making this timing requirement 
mandatory using SocketCAN is calling for trouble.

- Could remove the timing requirement. This is the easy solution. But 
there is the "Makes sense".

- The original strict timing requirement becomes an option so it's not a 
mandatory requirement.

2nd is my favorite (but I tend to do over engineering in the first shot 
so the option before may be indeed the better one).

Not having this timing behavior has the implication that in the next 
virtio draft spec some other things have to be changed and this means 
now simplified.

>> Thought this was doable with some implementation effort using
>>
>> setsockopt(..., SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, ...) and evaluatiing the
>> MSG_CONFIRM bit on received messages.
> Where does that code run? Would that be part of qemu running on the host
> of an open source solution?
The device application is closed source, runs under the COQOS hypervisor 
which is also closed source. A qemu device implementation is not planned 
as of now. The virtio CAN driver is a Linux device driver and will be 
open sourced at some point in time in the hope to get it upstreamed in a 
more far away future. Currently the driver is on an internal development 
branch, outsiders cannot see it (still better for everyone) and the 
colleagues are reviewing helping to bring it into an acceptable shape.
> Can you sketch a quick block diagram showing guest, host, Virtio device,
> Virtio driver, etc...

I hope this arrives on the list as is been sent and not garbled:

      Guest 2                    | Guest3
----------------                | ----------------
! cangen,      !                | ! cangen,      !
! candump,     !                | ! candump,     !
! cansend      !                | ! cansend      !
! using vcan0  !                | ! using can0   !
----------------                | ----------------
  ^                              |             ^
  !  ---------------------       |             !
  !  ! Service process   !       |             !
  !  ! in user space     !       |             !
  !  ! virtio-can device !       |             !
  !  ! forwarding vcan0  !       |             !
  !  ---------------------       |             !
  !    ^               ^         |             !
  !    !               !         |             !
--------------------------------------------------
  !    !   Device side ! kernel  | Driver side ! kernel
  v    v               v         |             v
---------------- -------------- | ----------------
! Device Linux ! ! HV support ! | ! Driver Linux !
!    VCan      ! !   module   ! | !  Virtio CAN  !
!    vcan0     ! ! on device  ! | !     can0     !
!              ! !   side     ! | !              !
---------------- -------------- | ----------------
        ^               ^        |        ^
        !               !        |        !
--------------------------------------------------
        !               !                 ! Hypervisor
        v               v                 v
--------------------------------------------------
!                     COQOS-HV                   !
--------------------------------------------------

>> This works fine with
>>
>> cangen -g 0 -i can0
>>
>> on the driver side sending CAN messages to the device guest. No confirmation
>> is lost testing for several minutes.
> Where's the driver side? On the host or the guest?

Both sides are guests of the hypervisor in our architecture. There is no 
host in this sense, COQOS-HV is a type 1 hypervisor. The hypervisor does 
not provide devices directly on its own, the devices are provided with 
the support of a device (provider) guest which is also only a guest of 
the hypervisor.

>
> Have you activated SO_RXQ_OVFL?
> With recvmsg() you get the number of dropped messages in the socket.
> Have a look at:
> https://github.com/linux-can/can-utils/blob/master/cansequence.c

I had no idea about SO_RXQ_OVFL. This looks to be useful to implement an 
emergency recovery mechanism not to get stuck. If detecting loss of 
received frames and the controller is still active and TX messages are 
pending for a too long time then marking the pending TX messages as used 
(done) to cope with the situation and not getting stuck (for too long). 
Might be acceptable if this was something which normally does not happen 
besides in really exceptional situations.

Nothing which should be done now, getting far too complicated for a 1st 
shot to implement a Virtio CAN device.

> We don't have a feature flag to query if the Linux driver support proper
> CAN echo on TX complete notification.

Not so nice. But the device integrator should know which backend is used 
and having a command line option for the device application the issue 
can be handled. Need the command line switch anyway now to do experiments.

Regards
Harald

-- 
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail:harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

