Return-Path: <linux-can+bounces-6068-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2AFD08F48
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 12:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664893007EDA
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CFD334C28;
	Fri,  9 Jan 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Eet1tQRS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rpxlo4dA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087911946C8
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958463; cv=pass; b=EdjTYYFpARLp8Yxg78pQuDtOuhjyZQeW48qWyZVRP16lAS9ep4C0/qggt6+5xplK3GRxallqb7bqhv5XMA0tTz5yvosEQj0Rs4OcY3XZ6MA1E7A6xAfxO6RWyz8AliXHG/hj+WhoBG24MSBVZKu6Kx+5pxjPm5V8masTwv5KJeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958463; c=relaxed/simple;
	bh=GKnwp6FzcnabDWW6h6WKLIIidOtj2fl14gls4+tu79A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCo5DBbtBN4pRQd/q069J3AZfibOl3qCfT6Y/aFcDyvp8wQBnlO+H+X9kTfCbXsYpcm2ImcKP20020WUF9waQIiBqZ5iAaIAp2G5fQZchTM4agisz1SmudmVKVJV5AN3hWxyc4+buDUbTwc7zsl6zglwCcvT+Wfk7fMeHNmCSsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Eet1tQRS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rpxlo4dA; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767958273; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UqU3XRoPBZLO1LwDeJRLzF7DTAwWqTYGBvHzVkYsCR6KDSmu3UrLYYP9MWwUKc7GIx
    dZjvGNRdvJuPmjFyk8QYtQ54kU6ZfWwuXEsKye+adCJwYy0UtQFLk2b3ZHMuM8Hc25HB
    2Y/OwtGaTt9aglrsu8d+3J6RJdenOQyIRQSd33E2kXEF6lRuUrnY/6ckdWD0zdVH/pO5
    1nZ6p/bbILx7qjS8jx9MpESIMxe5A8mClKLF3nOlPDTeRskI8VWtZWCKO8jwSaQFJuR5
    KhSBJ3YjUViEibBDiEWyaFgGDe0Z8I4gBRXibPeOwtHfex3+UTbQ4qUoPgUe2iTN0/O6
    OpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767958273;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IIjjMlBLznkhEaHGU3k/BR2Wi8NVgzeVf68QpGdAqrY=;
    b=lvL5wUvNmWl8crgRWbfPz11TqBcO0B6A4rZVSNCVWAPre/pmz7Waq0SmAkCmJEr8uT
    lpWdGBIszjqNvrduDwjMFGHMNQEumP3xatc+QE3qxysFk62vLlZqKhljqKyIB8Y1frZz
    QwfQIqC0rfAIWlrI+Sr1vrMLzn5PLQ7pZT9c6iAlTd00G3sx758JExtJnVHfbeACEfgh
    pfSQwqlYUxIF1XeWLbBwzfglawr8VJFajqayJGLjR4CoB+BCtsLMdHmh+Hj4Ei61bX9D
    83S4f+TkG9xX/7dwhghVgU1w0LS3MUa0EXI2cMeSJ4uJhnadWRSoAxYIB5XmOP6k8T9B
    QHdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767958273;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IIjjMlBLznkhEaHGU3k/BR2Wi8NVgzeVf68QpGdAqrY=;
    b=Eet1tQRSTFrSDNo4xsMEzhaQRb2pMaTgwZoaeFyJWCb/jwaJ4w8LKAeUJfvAsJLsmF
    fibL0QzNxPSteZS/sj/BlIapleVTIn2mnvq37eCYa+NXgUNz9ATsIPQ29UYT/l5urkCH
    MXwuWMDNQVSAWUEGi8TCq/TtYZueLdsUhdo6FqDqSkCTcTY4rKTBj/4+8ob/Z5A8nROV
    2JFUzif/grBEDnGWNWd2GMyrLPRxm3YP+IaQr43ym6zGCf8e8BsBIm4EJZ/cF8OPWDUq
    6qcNPFhUrZr4e76BzcgGoQMVFQ02UPEDb9N/Bng0lvC8ddPdPjRVC+8qNX2aKnQIqkTB
    jg4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767958273;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IIjjMlBLznkhEaHGU3k/BR2Wi8NVgzeVf68QpGdAqrY=;
    b=rpxlo4dA14eIhtraGr/QLNnWaGJB8MQnVgcp6YKgBAXjknaWirWFDLViYTTm2FhJDD
    X0+5rbjUs9IaH3F/fYBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209BVDO3D
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 12:31:13 +0100 (CET)
Message-ID: <a84166a4-7058-4dd9-b633-5c4cd0a48a28@hartkopp.net>
Date: Fri, 9 Jan 2026 12:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
 <20260109-fearless-diamond-gaur-90b52a-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260109-fearless-diamond-gaur-90b52a-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.01.26 11:37, Marc Kleine-Budde wrote:
> Can you please add a cover letter to this series.

Ok.
> 
> more comments inline...
> 
> On 01.01.2026 20:13:29, Oliver Hartkopp wrote:
>> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> caused a sequence of dependency and linker fixes.
>>
>> The entire problem was caused by the requirement that a new network layer
>> feature needed to know about the protocol capabilities of the CAN devices.
>> Instead of accessing CAN device internal data structures which caused the
>> dependency problems this patch introduces capability information into the
>> CAN specific ml_priv data which is accessible from both sides.
>>
>> With this change the CAN network layer can check the required features and
>> the decoupling of the driver layer and network layer is restored.
>>
>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/dev.c     | 24 ++++++++++++++++++++++++
>>   drivers/net/can/dev/netlink.c |  1 +
>>   drivers/net/can/vcan.c        | 15 +++++++++++++++
>>   drivers/net/can/vxcan.c       | 15 +++++++++++++++
>>   include/linux/can/can-ml.h    | 25 +++++++++++++++++++++++++
>>   include/linux/can/dev.h       |  1 +
>>   6 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 091f30e94c61..aaa669fc0d2b 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -373,10 +373,33 @@ void can_set_default_mtu(struct net_device *dev)
>>   		dev->min_mtu = CAN_MTU;
>>   		dev->max_mtu = CAN_MTU;
>>   	}
>>   }
>>
>> +void can_set_cap_info(struct net_device *dev)
>> +{
>> +	struct can_priv *priv = netdev_priv(dev);
>> +	u32 can_cap = CAN_CAP_CC;
> 
> I personally I would move the CAN_CAP_CC into the else branch. YMMV.
> 

Ok.

>> +
>> +	if (can_dev_in_xl_only_mode(priv)) {
>> +		/* XL only mode => no CC/FD capability */
>> +		can_cap = CAN_CAP_XL;
>> +	} else {
>> +		if (priv->ctrlmode & CAN_CTRLMODE_FD)
>> +			can_cap |= CAN_CAP_FD;
>> +
>> +		if (priv->ctrlmode & CAN_CTRLMODE_XL)
>> +			can_cap |= CAN_CAP_XL;
>> +	}
>> +
>> +	if (priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>> +			      CAN_CTRLMODE_RESTRICTED))
>> +		can_cap |= CAN_CAP_RO;
>> +
>> +	can_set_cap(dev, can_cap);
>> +}
>> +
> 
> [...]
> 
>> diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
>> index 8afa92d15a66..ff77097ae79f 100644
>> --- a/include/linux/can/can-ml.h
>> +++ b/include/linux/can/can-ml.h
>> @@ -44,10 +44,16 @@
>>
>>   #include <linux/can.h>
>>   #include <linux/list.h>
>>   #include <linux/netdevice.h>
>>
>> +/* exposed CAN device capabilities for network layer */
>> +#define CAN_CAP_CC 0x1U /* CAN CC aka Classical CAN */
>> +#define CAN_CAP_FD 0x2U /* CAN FD */
>> +#define CAN_CAP_XL 0x4U /* CAN XL */
>> +#define CAN_CAP_RO 0x8U /* read-only mode (LISTEN/RESTRICTED) */
> 
> Can we use BIT() here?
> 

Yes. Good idea.

>> +
>>   #define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
>>   #define CAN_EFF_RCV_HASH_BITS 10
>>   #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
>>
>>   enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
>> @@ -62,10 +68,11 @@ struct can_dev_rcv_lists {
>>   struct can_ml_priv {
>>   	struct can_dev_rcv_lists dev_rcv_lists;
>>   #ifdef CAN_J1939
>>   	struct j1939_priv *j1939_priv;
>>   #endif
>> +	u32 can_cap;
>>   };
>>
>>   static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
>>   {
>>   	return netdev_get_ml_priv(dev, ML_PRIV_CAN);
>> @@ -75,6 +82,24 @@ static inline void can_set_ml_priv(struct net_device *dev,
>>   				   struct can_ml_priv *ml_priv)
>>   {
>>   	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
>>   }
>>
>> +static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
>> +{
>> +	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
>> +
>> +	if (!can_ml)
>> +		return true;
> 
> Why is the capability enabled, if the device doesn't have a CAN ml_priv?

I have been thought about virtual CAN interfaces first but they also 
have a can_ml.

It's just a double-check if we really have a CAN interface here.
But returning false would make more sense then. Will change.

>> +
>> +	return (can_ml->can_cap & cap);
>> +}
>> +
>> +static inline void can_set_cap(struct net_device *dev, u32 cap)
>> +{
>> +	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
>> +
>> +	if (can_ml)
> 
> IMHO it's a bug if can_ml is NULL, it should not be ignored silently.
> Maybe just de-ref the NULL pointer?

Right the callers have a valid can_ml before calling can_set_cap().
Will remove this check.

Best regards,
Oliver

> 
>> +		can_ml->can_cap = cap;
>> +}
>> +
>>   #endif /* CAN_ML_H */
> 
> Thanks,
> Marc
> 


