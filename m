Return-Path: <linux-can+bounces-6006-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB2CF9307
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0013068BD8
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688F34CFD8;
	Tue,  6 Jan 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XNT0D/AK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YQLDpJv7"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14434CFBD
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714385; cv=pass; b=NCVB0c0gDbBz4/l8iovpFfo5geXUVPSWwkKAhjUX2dHFf8sfdS1SEzOw/Uu+yaFGuCsWS5S9L/IrGZk4T+fT0wAc5EV2G0oSTK3Zep0zzLbxv4IOuE1ZhXFKm+rNrNUj9/qtbrp9ogM97ew5m4XfIz4DbLNS1oFRUe76x3ZxMAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714385; c=relaxed/simple;
	bh=aUfCS2mVVOqxJCzNKUigLB1GzlWiQo79HlCV/lJGoas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgGDJmp0wBMOUs8SHw7L8/pcXtrpjdvX46IfzU82v0tmMv+cCgzc1QYaSFCCyUF4heWgjdJDuaLXrzfwVPELJFeLIO3YwGU5/2c3jMkYsP7BWURWhJtb+PeSTnuYG5MCFHS5MN6Jr5+z9NZM7/GhysY+7G560gVIbC2tmc6IlLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XNT0D/AK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YQLDpJv7; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767714013; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=atVx6ETZB76WtWHzm66Y6guZKF89jmO8n/RmNmAKQy7u1TjYt8TFWmp1mbumNNWj9y
    27kNXxZTD8Td21vgD9p3dn1Df/jX+Z5VHODt+DJNRmdoJpB2wol1WaROqPll4ccqu1St
    PevXDaOO8t5+RBcZgHIQmSmnyXx/wwgROZn3JqkrOYkez0I5UEkAkRdGtVx9X7WZ9f0o
    KBcYnGeic5vpR0uKs8ttEn73XipP7lDLwcO106uHiaOAhINFuBZzUMEEnGePaEAo5hRi
    ylREOqlnDb/2pKiJLeIRPwQccNg6gd2fApz0PoTqjLuJmze3+yZl4FtaiA9a98UF0K0N
    1/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767714013;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9qbKPSInm7y+YyZP7PnipCHlcs9BKoPwuDikhO9jsJA=;
    b=tZuzJzjYqiFTRVudzAbeqqFIAHKMyNLjLDFOxcb6Xq9s18CTDLU3pFE299HQBwz64g
    hZcG4/LD27PUWyidOWOE8Uv+nKuqxi879y+bwWNIRZxBd2XPuiNf8yyQGw5o13iqvygc
    u+HQabfPsivQYTGlWfQRoiDpBhTlUCvPLiY6QMBU0g+3Dotn9Z0m0aCWYAzeEPmPjE75
    zmAk4Ixve4VEJeRrMr5nKwCwGOa0SUiJ4A6U+KU837ag8WaJ1WFZUITJJG3dW0SqMQr+
    OSSp1gQvY00nxoaJpmBLxZcrfcBYN6wN6vAsJh48TdAD6lUyCMpnYdpnj6oZPA/EJA0H
    NDEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767714013;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9qbKPSInm7y+YyZP7PnipCHlcs9BKoPwuDikhO9jsJA=;
    b=XNT0D/AKtdVHd5SvVx1lKYINsXeY9YnKpmoJRxipJol6/vDOswnkCI4eojAPYdyjQH
    W2AiAgzNIq/jTM++ZcfRMrv+y2MyQaZ5aMa5X9Ui2rMVF+tQ0N1WogMmR6Kx0+Pp3CJb
    mc99m4zskNlO8hNRdiUGfuPchg+mmFrVdvHYe2gtLvtwXMPZAoQM71XZDqEWXHza2nTv
    lpGPj94R971MSVnBz3Dkf6n2YWqV2Rl3WKWWGpg8bcp9UKQ8SwMdNKpWE47m2QXo6fWQ
    Nx0j4iR7sG32+2JTtior6IVJfGo6t21L6Ecx7li6d1V196qKAjS/bhPoJZ6k1P3dNNEM
    N3fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767714013;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9qbKPSInm7y+YyZP7PnipCHlcs9BKoPwuDikhO9jsJA=;
    b=YQLDpJv7+rj4sMOgtGx9CClNUjI/2Ev5WFzQSgPetwQonKB1TbF4PZLhfICI0cO0/X
    ia5sqbFBrrWlmBl9/DAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b206FeD5kD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 6 Jan 2026 16:40:13 +0100 (CET)
Message-ID: <16a623ec-beb9-4968-bf16-75676d516c0e@hartkopp.net>
Date: Tue, 6 Jan 2026 16:40:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260101191330.1836-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc/Vincent,

On 01.01.26 20:13, Oliver Hartkopp wrote:
> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> caused a sequence of dependency and linker fixes.
> 
> The entire problem was caused by the requirement that a new network layer
> feature needed to know about the protocol capabilities of the CAN devices.
> Instead of accessing CAN device internal data structures which caused the
> dependency problems this patch introduces capability information into the
> CAN specific ml_priv data which is accessible from both sides.
> 
> With this change the CAN network layer can check the required features and
> the decoupling of the driver layer and network layer is restored.
> 
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")

Are you fine with this patch set?
I've tested it and it works as expected.

IMO the two patches after the revert should have no problems to be 
accepted as they restore the functionality we already had in 6.19-rc1.

Best regards,
Oliver

> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   drivers/net/can/dev/dev.c     | 24 ++++++++++++++++++++++++
>   drivers/net/can/dev/netlink.c |  1 +
>   drivers/net/can/vcan.c        | 15 +++++++++++++++
>   drivers/net/can/vxcan.c       | 15 +++++++++++++++
>   include/linux/can/can-ml.h    | 25 +++++++++++++++++++++++++
>   include/linux/can/dev.h       |  1 +
>   6 files changed, 81 insertions(+)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 091f30e94c61..aaa669fc0d2b 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -373,10 +373,33 @@ void can_set_default_mtu(struct net_device *dev)
>   		dev->min_mtu = CAN_MTU;
>   		dev->max_mtu = CAN_MTU;
>   	}
>   }
>   
> +void can_set_cap_info(struct net_device *dev)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +	u32 can_cap = CAN_CAP_CC;
> +
> +	if (can_dev_in_xl_only_mode(priv)) {
> +		/* XL only mode => no CC/FD capability */
> +		can_cap = CAN_CAP_XL;
> +	} else {
> +		if (priv->ctrlmode & CAN_CTRLMODE_FD)
> +			can_cap |= CAN_CAP_FD;
> +
> +		if (priv->ctrlmode & CAN_CTRLMODE_XL)
> +			can_cap |= CAN_CAP_XL;
> +	}
> +
> +	if (priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
> +			      CAN_CTRLMODE_RESTRICTED))
> +		can_cap |= CAN_CAP_RO;
> +
> +	can_set_cap(dev, can_cap);
> +}
> +
>   /* helper to define static CAN controller features at device creation time */
>   int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
>   
> @@ -388,10 +411,11 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
>   	}
>   	priv->ctrlmode = static_mode;
>   
>   	/* override MTU which was set by default in can_setup()? */
>   	can_set_default_mtu(dev);
> +	can_set_cap_info(dev);
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(can_set_static_ctrlmode);
>   
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index d6b0e686fb11..0498198a4696 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -375,10 +375,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
>   		memset(&priv->xl.pwm, 0, sizeof(priv->xl.pwm));
>   	}
>   
>   	can_set_default_mtu(dev);
> +	can_set_cap_info(dev);
>   
>   	return 0;
>   }
>   
>   static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index fdc662aea279..76e6b7b5c6a1 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -128,10 +128,23 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>   		consume_skb(skb);
>   	}
>   	return NETDEV_TX_OK;
>   }
>   
> +static void vcan_set_cap_info(struct net_device *dev)
> +{
> +	u32 can_cap = CAN_CAP_CC;
> +
> +	if (dev->mtu > CAN_MTU)
> +		can_cap |= CAN_CAP_FD;
> +
> +	if (dev->mtu >= CANXL_MIN_MTU)
> +		can_cap |= CAN_CAP_XL;
> +
> +	can_set_cap(dev, can_cap);
> +}
> +
>   static int vcan_change_mtu(struct net_device *dev, int new_mtu)
>   {
>   	/* Do not allow changing the MTU while running */
>   	if (dev->flags & IFF_UP)
>   		return -EBUSY;
> @@ -139,10 +152,11 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
>   	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
>   	    !can_is_canxl_dev_mtu(new_mtu))
>   		return -EINVAL;
>   
>   	WRITE_ONCE(dev->mtu, new_mtu);
> +	vcan_set_cap_info(dev);
>   	return 0;
>   }
>   
>   static const struct net_device_ops vcan_netdev_ops = {
>   	.ndo_start_xmit = vcan_tx,
> @@ -160,10 +174,11 @@ static void vcan_setup(struct net_device *dev)
>   	dev->hard_header_len	= 0;
>   	dev->addr_len		= 0;
>   	dev->tx_queue_len	= 0;
>   	dev->flags		= IFF_NOARP;
>   	can_set_ml_priv(dev, netdev_priv(dev));
> +	vcan_set_cap_info(dev);
>   
>   	/* set flags according to driver capabilities */
>   	if (echo)
>   		dev->flags |= IFF_ECHO;
>   
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index b2c19f8c5f8e..f14c6f02b662 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -123,10 +123,23 @@ static int vxcan_get_iflink(const struct net_device *dev)
>   	rcu_read_unlock();
>   
>   	return iflink;
>   }
>   
> +static void vxcan_set_cap_info(struct net_device *dev)
> +{
> +	u32 can_cap = CAN_CAP_CC;
> +
> +	if (dev->mtu > CAN_MTU)
> +		can_cap |= CAN_CAP_FD;
> +
> +	if (dev->mtu >= CANXL_MIN_MTU)
> +		can_cap |= CAN_CAP_XL;
> +
> +	can_set_cap(dev, can_cap);
> +}
> +
>   static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
>   {
>   	/* Do not allow changing the MTU while running */
>   	if (dev->flags & IFF_UP)
>   		return -EBUSY;
> @@ -134,10 +147,11 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
>   	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
>   	    !can_is_canxl_dev_mtu(new_mtu))
>   		return -EINVAL;
>   
>   	WRITE_ONCE(dev->mtu, new_mtu);
> +	vxcan_set_cap_info(dev);
>   	return 0;
>   }
>   
>   static const struct net_device_ops vxcan_netdev_ops = {
>   	.ndo_open	= vxcan_open,
> @@ -165,10 +179,11 @@ static void vxcan_setup(struct net_device *dev)
>   	dev->ethtool_ops	= &vxcan_ethtool_ops;
>   	dev->needs_free_netdev	= true;
>   
>   	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
>   	can_set_ml_priv(dev, can_ml);
> +	vxcan_set_cap_info(dev);
>   }
>   
>   /* forward declaration for rtnl_create_link() */
>   static struct rtnl_link_ops vxcan_link_ops;
>   
> diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
> index 8afa92d15a66..ff77097ae79f 100644
> --- a/include/linux/can/can-ml.h
> +++ b/include/linux/can/can-ml.h
> @@ -44,10 +44,16 @@
>   
>   #include <linux/can.h>
>   #include <linux/list.h>
>   #include <linux/netdevice.h>
>   
> +/* exposed CAN device capabilities for network layer */
> +#define CAN_CAP_CC 0x1U /* CAN CC aka Classical CAN */
> +#define CAN_CAP_FD 0x2U /* CAN FD */
> +#define CAN_CAP_XL 0x4U /* CAN XL */
> +#define CAN_CAP_RO 0x8U /* read-only mode (LISTEN/RESTRICTED) */
> +
>   #define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
>   #define CAN_EFF_RCV_HASH_BITS 10
>   #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
>   
>   enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
> @@ -62,10 +68,11 @@ struct can_dev_rcv_lists {
>   struct can_ml_priv {
>   	struct can_dev_rcv_lists dev_rcv_lists;
>   #ifdef CAN_J1939
>   	struct j1939_priv *j1939_priv;
>   #endif
> +	u32 can_cap;
>   };
>   
>   static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
>   {
>   	return netdev_get_ml_priv(dev, ML_PRIV_CAN);
> @@ -75,6 +82,24 @@ static inline void can_set_ml_priv(struct net_device *dev,
>   				   struct can_ml_priv *ml_priv)
>   {
>   	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
>   }
>   
> +static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
> +{
> +	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
> +
> +	if (!can_ml)
> +		return true;
> +
> +	return (can_ml->can_cap & cap);
> +}
> +
> +static inline void can_set_cap(struct net_device *dev, u32 cap)
> +{
> +	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
> +
> +	if (can_ml)
> +		can_ml->can_cap = cap;
> +}
> +
>   #endif /* CAN_ML_H */
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 52c8be5c160e..6d0710d6f571 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -114,10 +114,11 @@ void free_candev(struct net_device *dev);
>   struct can_priv *safe_candev_priv(struct net_device *dev);
>   
>   int open_candev(struct net_device *dev);
>   void close_candev(struct net_device *dev);
>   void can_set_default_mtu(struct net_device *dev);
> +void can_set_cap_info(struct net_device *dev);
>   int __must_check can_set_static_ctrlmode(struct net_device *dev,
>   					 u32 static_mode);
>   int can_hwtstamp_get(struct net_device *netdev,
>   		     struct kernel_hwtstamp_config *cfg);
>   int can_hwtstamp_set(struct net_device *netdev,


