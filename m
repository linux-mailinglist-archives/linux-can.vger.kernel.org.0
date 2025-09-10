Return-Path: <linux-can+bounces-4622-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE55B50ECE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 09:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1503BAB13
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D5307AFD;
	Wed, 10 Sep 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="V38QpYjY";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XXlpfjZm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E23064A7
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488333; cv=pass; b=P1my2L8bcpMZDI2vQEzCFAUf1OjmcTOvQuDdRvHLiU5nW4yEcwt+2YMUShYQ1Te3urTkQAP/zjO7g6HALGtPsHzLp5CDRBwSFxlsuOT/D5h0Bf1xLKccwfix39rSQzOTM3rZ/+F59EU3rddCg9t3EHd7SABEUqMBIk+qJ3Gciss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488333; c=relaxed/simple;
	bh=ZdH9qJ/ee0MXnNVRZJfDWyzQ7RT7tm8vXBJQHL0ZB9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBcsk4r0WsfWqG/cCKYHxuioY6bSc0m/XDOJFKUfI0QnIlnTY7jdAN9t3JnmwBJcq9xDrWrvyFYvMsun/3sGe//k8ePWzV12lpCAr86Adzya4a8tvqksP4A4UM05FC5PaDKl/bj6PjV/XteyIfLp0DmOj3XI6bwA5xq3wi4Krmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=V38QpYjY; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XXlpfjZm; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757488322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RELP2/AtAYq9w2iPgKUGtbLNTJPpub2EaETHJmkLaWEPZ3JzHvu0n+T9PxbYg6rJXK
    p0AvR5xBfwZ8fniNO5sX5dD3OCdvy9ZKaY1xc6/XZb4KJ01Dwzfh48Dtvs8FULmZj61y
    iislotgxuw6AvSaCAPhlYSRmLsbShIWfyXdNi875YGyuCihhrECKTg2g2WQTfyFblqCz
    nBodfUGuUfoobqGu2KlNJgReDRuh0Oj5O/xrU1br+9SOPJ8JwxwoWMytin28ZJ2NjzYQ
    XY+4qxqCXhpVrACvfyHI3ZFkxVvfxb0qGif5gPbgwq1nkxtyy57aVzrJM2/Xo9evVZoy
    /vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757488322;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bX3c9IjUV09FYtk7rT6n5W7NIeBsamfRgRefvqF43No=;
    b=UXgQPxT+3aJbmQH/bFvoP94TAaR0FtRHABJpSTdVLhUxAlaHs6rbKKT7DAWmnHo463
    LrCM7CcPBc7JSm6dFPXtF7OC++xJshurKkfI+zR4IxoLgJUyznSsXRoMm2W6UaDkthW2
    HlKm+MA3p72t7JSjGpcaRphq1z1/rAsSkiZpbW+zMG146zyKu1sopWUzQyKEAn7+uXkx
    3TrUgol8rwoOd5Yvq79DnzPuyf8V2OZ8l+pmcxWLUKIZ3Dg10MDRRoEuUrRiAR6SYCx+
    on7st08pVSvoZlkbF663nF1cQSMeFYR8iljGA8/Z//Epui2CQrw8yItLJR1+TKsQzQaf
    b0Rg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757488322;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bX3c9IjUV09FYtk7rT6n5W7NIeBsamfRgRefvqF43No=;
    b=V38QpYjYFuE37/NxMkI+AmN6ZsOKe/ESKQX98tWLFqFoNm4umDHceOp/rL0TPWmDYL
    4g4+1SPSIov8Y0DRCLbkybnoqeib8kIhba52kyHN6+vdngrCsPqQHo/om5ZPo5qI0bu4
    raqNBUUoLVlY43rOrtKU6IGN5dO/WLb6BdCeZnppyBDEO4fIjVWfKczdxdf5dB2BL+sf
    jqS9zbbtpzhm5QftlQkbT3Wmt45MKzadb1VzEDS91/u60KoKGxHZ+O09CCF1mg0ZKBK4
    MtX2CleZQ7L4oi+xuv/R6IS4D+NFcGigzmqLK/AZCnKehRs87mFq3o98xSgBt3ygB+wM
    2fhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757488322;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bX3c9IjUV09FYtk7rT6n5W7NIeBsamfRgRefvqF43No=;
    b=XXlpfjZmaPEdxSRc14VsmSq0Q1+3O2qW2YznszrdPaC327SIhPJEaVmzBBSrBpi5wS
    Vl+qx/ZkUlQ7bIT78UDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118A7C2na3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 09:12:02 +0200 (CEST)
Message-ID: <940c04d7-edc3-41ce-8997-8283dd838d89@hartkopp.net>
Date: Wed, 10 Sep 2025 09:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 1/2] can: skb: enforce CANFD_FDF check in
 can_is_canfd_skb()
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20250909163702.17755-1-socketcan@hartkopp.net>
 <CAMZ6RqK1cVT=xRhgFqCiUM4to2j37CoGq+uLrNt2tVPk+xTHhA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqK1cVT=xRhgFqCiUM4to2j37CoGq+uLrNt2tVPk+xTHhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.09.25 06:13, Vincent Mailhol wrote:
> On Wed. 10 sept. 2025 at 01:37, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> The check in can_is_canfd_skb() is about a length check of skb->len and
>> the CAN FD data length. As a skb length of CANFD_MTU can potentially be
>> created with a CAN XL frame with a data length of 60, the length check of
>> the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
>> flag which exceeds valid CAN FD data length values.
>>
>> To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
>> frame skbs the bit is set in can_send() which is used by all PF_CAN
>> protocols. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.
>>
>> The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
>> uncertainty when using the skb->len check with the CANFD_MTU.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/linux/can/skb.h | 19 +++++++++++++++++--
>>   net/can/af_can.c        |  2 +-
>>   net/can/raw.c           |  2 +-
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>> index 1abc25a8d144..09ab4dc83199 100644
>> --- a/include/linux/can/skb.h
>> +++ b/include/linux/can/skb.h
>> @@ -107,18 +107,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
>>
>>          /* the CAN specific type of skb is identified by its data length */
>>          return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
>>   }
>>
>> -static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>> +static inline bool can_is_canfd_skb_mtu_len(const struct sk_buff *skb)
>>   {
>>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>
>> -       /* the CAN specific type of skb is identified by its data length */
>> +       /* The CAN specific type of skb is identified by its data length.
>> +        * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
>> +        * skb would have the CANXL_XLF bit set (0x80 = 128) in the
>> +        * cfd->len field position which would intentionally break the
>> +        * CAN FD length check here.
>> +        */
>>          return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
>>   }
>>
>> +static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>> +{
>> +       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>> +
>> +       if (!can_is_canfd_skb_mtu_len(skb))
>> +               return false;
>> +
>> +       return cfd->flags & CANFD_FDF;
>> +}
> 
> How does this new can_is_canfd_skb() operate if a can frame is sent
> through the PF_PACKET interface?
> 
> Wouldn't the frame bypass the can_send() and reach the driver's xmit()
> function without the CANFD_FDF flag set?
> 

Yes, but the drivers are widely using can_is_canfd_skb().

But your remark let's me rethink this entire patch.

When I started to integrate CAN XL I moved the canxl_frame.flags to the 
position of can(fd)_frame.len to intentionally break the data length 
check, when CANXL_XLF (0x80) is set.

When CANXL_XLF is not set with a skb->len == CANFD_MTU we simply have a 
CAN FD frame here. Period.

That the Linux kernel generates CAN_FD frames with CANFD_FDF set since 
commit 061834624c872 was only intended to help the user space and to 
ease the use of struct canfd_frame as dual use CC/FD data structure.

The differentiation of CAN CC and CAN FD was always done by the 
structure length (MTU) for more than 12 years. So when you e.g. replay 
an old capture file with WireShark that does not have CANFD_FDF bit set, 
it might render the capture file unusable. Which is an UAPI break.

I tend to drop this entire patch and will concentrate on the patch that 
early gives a feedback to the user of the CAN_RAW socket when it is not 
allowed to send specific CAN frame types.

Btw. this does not make those checks unnecessary on the driver level as 
the outgoing skb's might have been created with PF_PACKET.

Best regards,
Oliver


>>   static inline bool can_is_canxl_skb(const struct sk_buff *skb)
>>   {
>>          const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
>>
>>          if (skb->len < CANXL_HDR_SIZE + CANXL_MIN_DLEN || skb->len > CANXL_MTU)
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index b2387a46794a..7fd2ed510440 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -207,11 +207,11 @@ int can_send(struct sk_buff *skb, int loop)
>>
>>          if (can_is_canxl_skb(skb)) {
>>                  skb->protocol = htons(ETH_P_CANXL);
>>          } else if (can_is_can_skb(skb)) {
>>                  skb->protocol = htons(ETH_P_CAN);
>> -       } else if (can_is_canfd_skb(skb)) {
>> +       } else if (can_is_canfd_skb_mtu_len(skb)) {
>>                  struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>
>>                  skb->protocol = htons(ETH_P_CANFD);
>>
>>                  /* set CAN FD flag for CAN FD frames by default */
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 76b867d21def..e5e3952b0e09 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>>          /* Classical CAN -> no checks for flags and device capabilities */
>>          if (can_is_can_skb(skb))
>>                  return CAN_MTU;
>>
>>          /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>> -       if (ro->fd_frames && can_is_canfd_skb(skb) &&
>> +       if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
>>              (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>>                  return CANFD_MTU;
>>
>>          /* CAN XL -> needs to be enabled and a CAN XL device */
>>          if (ro->xl_frames && can_is_canxl_skb(skb) &&


