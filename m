Return-Path: <linux-can+bounces-473-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18498AE115
	for <lists+linux-can@lfdr.de>; Tue, 23 Apr 2024 11:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D621F2150C
	for <lists+linux-can@lfdr.de>; Tue, 23 Apr 2024 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA045FBBA;
	Tue, 23 Apr 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="IbQo6Yo9"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7759148;
	Tue, 23 Apr 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864845; cv=none; b=m73EtnQEgduLpkURVk9xiO7CiD+Mdpky+jYJ3OjTDAQFSphkD44kM7XCSKOxHJ14Jh3erJub5v6c7gggGsuYnLkZXfdo33Kls6ostCjwFBzzamQ4QDGVxcCIlIXUUtkf6RFk0YsLUBH4QrTEn50Y83Q4PnbYkU7yfO4Hjl+EUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864845; c=relaxed/simple;
	bh=hW/MSIqixDoWTQPsb1jY1aJlgqcGAnzc07luQQKSUJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sbanmUbkzHCt5TjoBn/3DNYXDc9lbaiEFejVq6O0pRekhXj4U83KqBSGmMUVgah6ljzVv6oJmpbVO2KbI0k43N9YGGdzhwbq8yy72O3GpsoEOfXdyOXpr5gKNxza00b0L+X+zmnjJ1doRyzy2UM2ID0fTZRSCsnFe/uGQZUUZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=IbQo6Yo9; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O7Ga/+MQslFYLFemzYWK7NMgPsWPI6GzChQN73PPCu8=; b=IbQo6Yo9ix8PPIhPR78eQvZZ5c
	QzaJxedwlfH4Vfh3gJH+5ioI7g+9nB/8r/W8HruwIS6W6uAE2nM5//VU35RPBJD6eOhMub7YGP2Jy
	EgwF6V+4o/48ML6pQBAY39H/ORMERYKouKnLdd59pbdQqRn4Z/VNgNrY311PeLMs9srA=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rzCWy-001LNj-0F;
	Tue, 23 Apr 2024 11:33:40 +0200
Message-ID: <43a8b0484e5b4e7d550a665aa4f7b37186d030f7.camel@hexdev.de>
Subject: Re: [PATCH 01/11] can: Add LIN bus as CAN abstraction
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Tue, 23 Apr 2024 11:33:35 +0200
In-Reply-To: <cf9109ac-f17b-4812-aa50-449b8fb9504e@kernel.org>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
	 <20240422065114.3185505-2-christoph.fritz@hexdev.de>
	 <cf9109ac-f17b-4812-aa50-449b8fb9504e@kernel.org>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

...
> > --- /dev/null
> > +++ b/drivers/net/can/lin.c
> ...> +static int lin_create_sysfs_id_files(struct net_device *ndev)
> > +{
> > +	struct lin_device *ldev = netdev_priv(ndev);
> > +	struct kobj_attribute *attr;
> > +	int ret;
> > +
> > +	for (int id = 0; id < LIN_NUM_IDS; id++) {
> > +		ldev->sysfs_entries[id].ldev = ldev;
> > +		attr = &ldev->sysfs_entries[id].attr;
> > +		attr->attr.name = kasprintf(GFP_KERNEL, "%02x", id);
> > +		if (!attr->attr.name)
> > +			return -ENOMEM;
> > +		attr->attr.mode = 0644;
> > +		attr->show = lin_identifier_show;
> > +		attr->store = lin_identifier_store;
> > +
> > +		sysfs_attr_init(&attr->attr);
> > +		ret = sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
> > +		if (ret) {
> > +			kfree(attr->attr.name);
> > +			kfree(attr);
> 
> Is the latter kfree() right? It appears not.

Thanks for the catch, it's wrong and will be removed in v2.

> 
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> ...
> > +static void lin_tx_work_handler(struct work_struct *ws)
> > +{
> > +	struct lin_device *ldev = container_of(ws, struct lin_device,
> > +					       tx_work);
> > +	struct net_device *ndev = ldev->ndev;
> > +	struct canfd_frame *cfd;
> > +	struct lin_frame lf;
> > +
> > +	ldev->tx_busy = true;
> 
> How is this store protected against reordering/race conditions?

Falsely it is not, like in mcp251x.c I'll add a mutex.

> 
> > +
> > +	cfd = (struct canfd_frame *)ldev->tx_skb->data;
> > +	lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
> > +			   LINBUS_ENHANCED : LINBUS_CLASSIC;
> > +	lf.lin_id = (u8)(cfd->can_id & LIN_ID_MASK);
> 
> Why is that cast necessary?

It's not.

> 
> > +	lf.len = min(cfd->len, LIN_MAX_DLEN);
> > +	memcpy(lf.data, cfd->data, lf.len);
> > +
> > +	ret = ldev->ldev_ops->ldo_tx(ldev, &lf);
> > +	if (ret) {
> > +		DEV_STATS_INC(ndev, tx_dropped);
> > +		netdev_err_once(ndev, "transmission failure %d\n", ret);
> > +		goto lin_tx_out;
> 
> Where is this label?

In a later patch, let me fix the patchset accordingly.

> 
> > +	}
> > +
> > +	DEV_STATS_INC(ndev, tx_packets);
> > +	DEV_STATS_ADD(ndev, tx_bytes, lf.len);
> > +	ldev->tx_busy = false;
> 
> The same as above.

OK

> 
> > +	netif_wake_queue(ndev);
> > +}
> > +
> > +static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
> > +				  struct net_device *ndev)
> > +{
> > +	struct lin_device *ldev = netdev_priv(ndev);
> > +
> > +	if (ldev->tx_busy)
> > +		return NETDEV_TX_BUSY;
> 
> And here too.

OK

> 
> > +
> > +	netif_stop_queue(ndev);
> > +	ldev->tx_skb = skb;
> > +	queue_work(ldev->wq, &ldev->tx_work);
> > +
> > +	return NETDEV_TX_OK;
> > +}
> ...
> > +u8 lin_get_checksum(u8 pid, u8 n_of_bytes, const u8 *bytes,
> > +		    enum lin_checksum_mode cm)
> > +{
> > +	uint csum = 0;
> 
> Is "uint" of the preffered types in the kernel?

OK, no sysv 'uint', will be changed in another patch too

> 
> > +	int i;
> > +
> > +	if (cm == LINBUS_ENHANCED)
> > +		csum += pid;
> > +
> > +	for (i = 0; i < n_of_bytes; i++) {
> > +		csum += bytes[i];
> > +		if (csum > 255)
> > +			csum -= 255;
> > +	}
> > +
> > +	return (u8)(~csum & 0xff);
> 
> Unnecessary cast?

Yes

> 
> > +}
> 
> 
> > +int lin_rx(struct lin_device *ldev, const struct lin_frame *lf)
> > +{
> > +	struct net_device *ndev = ldev->ndev;
> > +	struct can_frame *cf;
> > +	struct sk_buff *skb;
> > +	int ret;
> > +
> > +	if (!ndev)
> > +		return -ENODEV;
> 
> Is this racy or is this only a sanity check?

Just beeing cautious, I guess it can be removed

> 
> > +	netdev_dbg(ndev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> > +		   lf->lin_id, lf->len, lf->len, lf->data, lf->checksum,
> > +		   lf->checksum_mode ? "enhanced" : "classic");
> > +
> > +	ret = lin_bump_rx_err(ldev, lf);
> > +	if (ret) {
> > +		DEV_STATS_INC(ndev, rx_dropped);
> > +		return ret;
> > +	}
> > +
> > +	skb = alloc_can_skb(ndev, &cf);
> > +	if (unlikely(!skb)) {
> > +		DEV_STATS_INC(ndev, rx_dropped);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cf->can_id = lf->lin_id;
> > +	cf->len = min(lf->len, LIN_MAX_DLEN);
> > +	memcpy(cf->data, lf->data, cf->len);
> > +
> > +	DEV_STATS_INC(ndev, rx_packets);
> > +	DEV_STATS_ADD(ndev, rx_bytes, cf->len);
> > +
> > +	netif_receive_skb(skb);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(lin_rx);
> > +
> > +static int lin_set_bittiming(struct net_device *ndev)
> > +{
> > +	struct lin_device *ldev = netdev_priv(ndev);
> > +	unsigned int bitrate;
> > +	int ret;
> > +
> > +	bitrate = ldev->can.bittiming.bitrate;
> > +	ret = ldev->ldev_ops->update_bitrate(ldev, bitrate);
> > +
> > +	return ret;
> 
> No need for ret then.

Compact code, sure, will get adapted

> 
> > +}
> > +
> > +static const u32 lin_bitrate[] = { 1200, 2400, 4800, 9600, 19200 };
> > +
> > +struct lin_device *register_lin(struct device *dev,
> > +				const struct lin_device_ops *ldops)
> > +{
> > +	struct net_device *ndev;
> > +	struct lin_device *ldev;
> > +	int ret;
> > +
> > +	if (!ldops || !ldops->ldo_tx || !ldops->update_bitrate) {
> > +		netdev_err(ndev, "missing mandatory lin_device_ops\n");
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> Would EINVAL fit better?

no preference over the other, will use EINVAL

> 
> > +	}
> > +
> > +	ndev = alloc_candev(sizeof(struct lin_device), 1);
> > +	if (!ndev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ldev = netdev_priv(ndev);
> > +
> > +	ldev->ldev_ops = ldops;
> > +	ndev->netdev_ops = &lin_netdev_ops;
> > +	ndev->flags |= IFF_ECHO;
> > +	ndev->mtu = CANFD_MTU;
> > +	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
> > +	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
> > +	ldev->can.ctrlmode_supported = 0;
> > +	ldev->can.bitrate_const = lin_bitrate;
> > +	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
> > +	ldev->can.do_set_bittiming = lin_set_bittiming;
> > +	ldev->ndev = ndev;
> > +	ldev->dev = dev;
> > +
> > +	SET_NETDEV_DEV(ndev, dev);
> > +
> > +	ret = lin_set_bittiming(ndev);
> > +	if (ret) {
> > +		netdev_err(ndev, "set bittiming failed\n");
> > +		goto exit_candev;
> > +	}
> > +
> > +	ret = register_candev(ndev);
> > +	if (ret)
> > +		goto exit_candev;
> > +
> > +	ldev->lin_ids_kobj = kobject_create_and_add("lin_ids", &ndev->dev.kobj);
> > +	if (!ldev->lin_ids_kobj) {
> > +		netdev_err(ndev, "Failed to create sysfs directory\n");
> > +		ret = -ENOMEM;
> > +		goto exit_unreg;
> > +	}
> > +
> > +	ret = lin_create_sysfs_id_files(ndev);
> > +	if (ret) {
> > +		netdev_err(ndev, "Failed to create sysfs entry: %d\n", ret);
> > +		goto exit_kobj_put;
> > +	}
> > +
> > +	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
> > +				   0);
> 
> It would be worth noting why you need your own WQ.

I'll add a comment stating:

/* Use workqueue as tx over USB/SPI/... may sleep */

> 
> > +	if (!ldev->wq)
> > +		goto exit_rm_files;
> > +
> > +	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
> > +
> > +	netdev_info(ndev, "LIN initialized.\n");
> > +
> > +	return ldev;
> > +
> > +exit_rm_files:
> > +	lin_remove_sysfs_id_files(ndev);
> > +exit_kobj_put:
> > +	kobject_put(ldev->lin_ids_kobj);
> > +exit_unreg:
> > +	unregister_candev(ndev);
> > +exit_candev:
> > +	free_candev(ndev);
> > +	return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(register_lin);
> > +
> > +void unregister_lin(struct lin_device *ldev)
> > +{
> > +	struct net_device *ndev = ldev->ndev;
> > +
> > +	lin_remove_sysfs_id_files(ndev);
> > +	kobject_put(ldev->lin_ids_kobj);
> > +	unregister_candev(ndev);
> > +	destroy_workqueue(ldev->wq);
> > +	free_candev(ndev);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_lin);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> > +MODULE_DESCRIPTION("LIN bus to CAN glue driver");
> > diff --git a/include/net/lin.h b/include/net/lin.h
> > new file mode 100644
> > index 0000000000000..2fe16e142db96
> > --- /dev/null
> > +++ b/include/net/lin.h
> > @@ -0,0 +1,97 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> > +
> > +#ifndef _NET_LIN_H_
> > +#define _NET_LIN_H_
> > +
> > +#include <linux/can/dev.h>
> > +#include <linux/device.h>
> > +
> > +#define LIN_NUM_IDS		64
> > +#define LIN_HEADER_SIZE		3
> > +#define LIN_MAX_DLEN		8
> > +
> > +#define LIN_MAX_BAUDRATE	20000
> > +#define LIN_MIN_BAUDRATE	1000
> > +#define LIN_DEFAULT_BAUDRATE	9600
> > +#define LIN_SYNC_BYTE		0x55
> > +
> > +#define LIN_ID_MASK		0x0000003FU
> 
> GEN_MASK() ?

In the upcoming v2 I'll use:

#define LIN_ID_MASK   GENMASK(5, 0)

> 
> > +/* special ID descriptions for LIN */
> > +#define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
> > +
> > +static const unsigned char lin_id_parity_tbl[] = {
> 
> This ends up in every translation unit you include lin.h into. Bad.

This is also being used by a serial lin driver. But I guess most of the drivers have no need for this. Mhm, ... any ideas?

> And perhaps u8?

OK

> 
> > +	0x80, 0xc0, 0x40, 0x00, 0xc0, 0x80, 0x00, 0x40,
> > +	0x00, 0x40, 0xc0, 0x80, 0x40, 0x00, 0x80, 0xc0,
> > +	0x40, 0x00, 0x80, 0xc0, 0x00, 0x40, 0xc0, 0x80,
> > +	0xc0, 0x80, 0x00, 0x40, 0x80, 0xc0, 0x40, 0x00,
> > +	0x00, 0x40, 0xc0, 0x80, 0x40, 0x00, 0x80, 0xc0,
> > +	0x80, 0xc0, 0x40, 0x00, 0xc0, 0x80, 0x00, 0x40,
> > +	0xc0, 0x80, 0x00, 0x40, 0x80, 0xc0, 0x40, 0x00,
> > +	0x40, 0x00, 0x80, 0xc0, 0x00, 0x40, 0xc0, 0x80,
> > +};
> > +
> > +#define LIN_GET_ID(PID)		((PID) & LIN_ID_MASK)
> 
> FIELD_GET() ?

In the upcoming v2 I'll use:

#define LIN_GET_ID(PID)		FIELD_GET(LIN_ID_MASK, PID)

> 
> > +#define LIN_FORM_PID(ID)	(LIN_GET_ID(ID) | \
> > +					lin_id_parity_tbl[LIN_GET_ID(ID)])
> > +#define LIN_GET_PARITY(PID)	((PID) & ~LIN_ID_MASK)
> > +#define LIN_CHECK_PID(PID)	(LIN_GET_PARITY(PID) == \
> > +					LIN_GET_PARITY(LIN_FORM_PID(PID)))
> 

Thanks for the feedback
  -- Christoph

