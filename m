Return-Path: <linux-can+bounces-4549-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D0B4A579
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91D47AF817
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005824EF76;
	Tue,  9 Sep 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b+6XYkfO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pj/DeIJV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C57253F05
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406961; cv=pass; b=CYvJI23TpVfl8m96t8hKfgiYe8IrmHHYElWYerlJFcOjCSt2Zd2dR8F+htHhK6kyrFI/oD5V2DzqUGNFe34Ooem3z0PU18o0rl1l69wJIgp9pxorl/4gvkGYnA8RyA5gdDGn1kgFOFc15cvfNwoxKoTAYPIGWI+BIMUNCwKBeho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406961; c=relaxed/simple;
	bh=geWANWmkvc7gW4LAaXHEew0mGMFDNgFKkYlzgYOD4MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D46MztVbt8HNDI+gvoDRu9/OzfxTnI/KTaRYjBVviGYRz3HzHbh8E8bOiRRMV+fWqK462LXXcIMz/7Jiy2GB21Cv2YYHDuT4xCfL/nXwoqRxzSJqUuOX6YBLgafUYYSPRzJoFYtlhw6r+ulZkbLEU7j0TvSU+dCWEWhTHSAmWEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b+6XYkfO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pj/DeIJV; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757406950; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Tur3IVtm/7dhsqg63lDxCpkxrItBhF6DqO1/XBg3AkAUfFXPSm5FMn8qPpg8sn1DJQ
    2A5ocnJnLraUBoYavvpPcgAMz2tUxCBM0zMDtSV93anv3uyIoYZHlLVobKVPD0DMObM8
    GuegLFuVD15kbnBaPEb163Cnr4REpqqMJiZYoPyf/yg375ggmVwFGDWFFtRFrk2u7EE3
    F+B2omz3SJCIMtyEQm2ELvpAUVvMixzRdRDL0VHOZpSAEL0tmO+LEYcf8f+iv1fDIMD5
    Zk50/dYPMnObNZtGZ5gF37nMBKZjXd+nv0s7EPaVGWy0S18QJQ/OjoiCQoVP1WaVUijD
    nFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406950;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=omMkZ1JAx4pXMoS4rlBKdS6oCpkgd5TzI6Gt/WMpOOw=;
    b=jqCIIFU4+HNTmh3rnLzpzFS5UvbLaPLg3KQ3hCaU0Opr9Ns0qBOeNZPNuEoOGr1w5O
    mGtduQ8/z+MewGtq7SHSH03WEquMFCYnnzuLxppDNhTQA3t7MA+RQoHAxsIRSSvFEVs9
    TmWhSsHjYXSFPGGNJAnE1agiHAuG+wImnxKKNSi/tfstwTrmdB/vWH3p0ZG1okxTi82Q
    zIUwDUbew++1GwTJT0t0KsKhDdACjmIRTqkMmmHXote3oSch8O3qHi7oc62whWHbCSE8
    cLU5vq18+8rb6b1lIjGtXYvKi8nOULjcjY4j7RxsjZH8s5/I1AVH2wtIJqGir1LlgoJ7
    IiKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406950;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=omMkZ1JAx4pXMoS4rlBKdS6oCpkgd5TzI6Gt/WMpOOw=;
    b=b+6XYkfOXPTOe070JQvO6iD/BsW3V3VKe4LJWAfh0mwp2nYfVzE16SiPVBDOhl2BKo
    TWhSKl44U6ZH3FvsHoMeCReEsRZqWTV7oFjfYywRnDVDND15Qy9kl6VNH9T2YrftLzQz
    AY6Kf7ALcpiM03lZpYhae5uXHzZE7TpQA3xmmB1Mk8bICA+YnnVAg++KqIlHhh+2cBWE
    sscVMwtfpo6/nInh1936pJZ1fXxy+IE8+xQdhzQVjgr9OkXpHvp6VJuCqyHBd+TNIOee
    lnxDJDV9mib6nxJ9gIF0cHsfH2gf4kkA98wbrZtUdZBgWtTmymZYzcMVtHKpMxaBpdbT
    SnMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757406950;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=omMkZ1JAx4pXMoS4rlBKdS6oCpkgd5TzI6Gt/WMpOOw=;
    b=pj/DeIJVOfxYk7p36jU64secxeyL92RxZeLm45AralPxkefUiK7wsK6QeEEnRHkWIO
    7ph2Rh/M0odcluVKRdAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611898Zoecy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 10:35:50 +0200 (CEST)
Message-ID: <7cbf8085-2df2-4a3e-8e20-73f588dad590@hartkopp.net>
Date: Tue, 9 Sep 2025 10:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/2] can: skb: enforce CANFD_FDF check in
 can_is_canfd_skb()
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20250908184512.78449-1-socketcan@hartkopp.net>
 <CAMZ6RqKiwmFzuFxxYvbLYr4-5AkDG7+W2zigqR8uvqSWv952JQ@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKiwmFzuFxxYvbLYr4-5AkDG7+W2zigqR8uvqSWv952JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.09.25 08:25, Vincent Mailhol wrote:
> On Tue. 9 Sep. 2025 at 03:45, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> The check in can_is_canfd_skb() is about a length check of skb->len and
>> the CAN FD data length. As a skb length of CANFD_MTU can potentially be
>> created with a CAN XL frame with a data length of 60, the length check of
>> the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
>> flag which exceeds valid CAN FD data length values.
>>
>> To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
>> frame skbs the bit was set in can_send() and is now also set in
>> raw_check_txframe() to re-use the indroduced can_is_canfd_skb_set_fdf()
>> function. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.
>>
>> The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
>> uncertainty when using the skb->len check with the CANFD_MTU.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/linux/can/skb.h | 25 +++++++++++++++++++++++--
>>   net/can/af_can.c        |  7 +------
>>   net/can/raw.c           |  2 +-
>>   3 files changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>> index 1abc25a8d144..38d036b43280 100644
>> --- a/include/linux/can/skb.h
>> +++ b/include/linux/can/skb.h
>> @@ -111,12 +111,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
>>
>>   static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>>   {
>>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>
>> -       /* the CAN specific type of skb is identified by its data length */
>> -       return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
>> +       if (skb->len != CANFD_MTU || cfd->len > CANFD_MAX_DLEN)
>> +               return false;
>> +
>> +       return cfd->flags & CANFD_FDF;
>> +}
>> +
>> +static inline bool can_is_canfd_skb_set_fdf(const struct sk_buff *skb)
>> +{
>> +       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>> +
>> +       /* The CAN specific type of skb is identified by its data length.
>> +        * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
>> +        * skb would have the CANXL_XLF bit set (0x80 = 128) in the
>> +        * cfd->len field position which would intentionally break the
>> +        * CAN FD length check here. So we can surely tag it as CAN FD.
>> +        */
>> +       if (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN) {
>> +               /* set CAN FD flag for CAN FD frames by default */
>> +               cfd->flags |= CANFD_FDF;
>> +               return true;
>> +       }
>> +
>> +       return false;
>>   }
>>
>>   static inline bool can_is_canxl_skb(const struct sk_buff *skb)
>>   {
>>          const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index b2387a46794a..0caf75a9e27f 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -207,17 +207,12 @@ int can_send(struct sk_buff *skb, int loop)
>>
>>          if (can_is_canxl_skb(skb)) {
>>                  skb->protocol = htons(ETH_P_CANXL);
>>          } else if (can_is_can_skb(skb)) {
>>                  skb->protocol = htons(ETH_P_CAN);
>> -       } else if (can_is_canfd_skb(skb)) {
>> -               struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>> -
>> +       } else if (can_is_canfd_skb_set_fdf(skb)) {
>>                  skb->protocol = htons(ETH_P_CANFD);
>> -
>> -               /* set CAN FD flag for CAN FD frames by default */
>> -               cfd->flags |= CANFD_FDF;
>>          } else {
>>                  goto inval_skb;
>>          }
>>
>>          /* Make sure the CAN frame can pass the selected CAN netdevice. */
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 76b867d21def..f48b1f3fd6e8 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
> 
> With this change, raw_check_txframe() now has a side effect. It will
> set the CANFD_FDF under some conditions. This is weird for a function
> named "check". When I read the code, I expected a check function to
> not have such side effects.
> 
> I would suggest to set the flag in raw_sendmsg(), something like that:
> 
>           txmtu = raw_check_txframe(ro, skb, dev->mtu);
>           if (!txmtu)
>                   goto free_skb;
> 
> +        /* set CAN FD flag for CAN FD frames by default */
> +        if (txmtu == CANFD_MTU) {
> +                struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +                cfd->flags |= CANFD_FDF;
> +        }
> +

Right. I've seen this remark to late for my v4.
Will propose a better solution.

Best regards,
Oliver

>           /* only CANXL: clear/forward/set VCID value */
>           if (txmtu == CANXL_MTU)
>                   raw_put_canxl_vcid(ro, skb);
> 
>>          /* Classical CAN -> no checks for flags and device capabilities */
>>          if (can_is_can_skb(skb))
>>                  return CAN_MTU;
>>
>>          /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>> -       if (ro->fd_frames && can_is_canfd_skb(skb) &&
>> +       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
>>              (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>>                  return CANFD_MTU;
>>
>>          /* CAN XL -> needs to be enabled and a CAN XL device */
>>          if (ro->xl_frames && can_is_canxl_skb(skb) &&


