Return-Path: <linux-can+bounces-467-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C18AC683
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1261C21409
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199694F60D;
	Mon, 22 Apr 2024 08:16:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657A4F213;
	Mon, 22 Apr 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773774; cv=none; b=lhL02/QqWXnPuBqvQp8R1/Yn0NJEv8Hu/XRi+9/RwMUowDc7xzqMYrdXv8vV9BzEoijpkZ+JgEqXx5oVnUFelfA8eCfabSLDRQsqgOOOX5laDmZCas+3WLVWPbJw/ZrSSPFGL1SPjPXxzd0PTIqHpKbCGwnli2rcnneRV5qEWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773774; c=relaxed/simple;
	bh=qAWlMO+mJckBfsgbgVLMe7pu85yrkM2x3clj1P0pEMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB1WPVXtwlb47At4BnLoyFNM9nRplSx1c5lKcBKl7KoWMs/m3UuYfLyayUXR1PfarXNf/8tc2cTh4eMPHi9RlgrdjTzMrvUkQjimKnTQLMpmhSeKtWZqIY2x+xzNZPGyQblrgjUasHyNLeh7iq2PG4I3Vh8YDue38BGfE6eyac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55b78510bbso60356466b.0;
        Mon, 22 Apr 2024 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773770; x=1714378570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gm3/+eIAlVK76IUGUfx20Iohyy5DG5rA1sUx7ABxCI=;
        b=rjt8Q4trmIFniBgd8CKym0Vkilza9rfcIdFlys9cM0PNtqYQBUoQWZ33w2k8rzk5UK
         8zq5aBz5/paH4tLVTunuySvhRbj1W1oxLfBTry9C1LtkcbWIgS0GbFtdgG0Rbpk7jHtY
         0YQ5JRU3uYJKGH40SBKjwe5/VICbBndmzcsbln+Io/VFazOESZJzOc4FIoHarQGOB2W4
         Uv+FZhMRIjrq9Foz3VtX7/fXuuRiwmcOwuW+Geah32w+jLBDfXf8TazSzzxXo+LkYwYj
         hXa3Eo/g42JTEkDPOBbA188UPsNhHSa/FOqGpZx3yXSLqBniY2ooOYGn1fN53EREa0ry
         UwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZKvqtCXC++GqAI+kvO/vZ2DEBOnMtNmX1R4V/sjuuKD0de2kE+xdVjJLww0hNs3OQh2wmZxSJkTDXUEZmHgUztiOiX/HxyDX9nZhCkzpkaN1/Lgf+Z1JvpiliGCs2bCT7pR2QcKzHp2aWOFm7NOT+4LiR/0QxLIECCLCLlhMY9xRkAXuGICUdabPtg6O1por00itL75giEE87lleDZZWjvgYruWKyHh08H9fCW6/qR5ElDCW5ljg
X-Gm-Message-State: AOJu0YzBOgfl7UUKmVsWzOvP4A9VNm9Z2et7DW71SgWG8tm1MXDRMeJx
	GslpFUcKLQYUuQLg/17M0SNS82pM6mwGpBrYO3leMuMGtoovcegf
X-Google-Smtp-Source: AGHT+IHoFdg7F/YVJ5s+QHYIV5PCqNr1/E7zg4Ly33+6ykDlUT+Ah6m05PDLTTlcZkTtUguOCb1KFQ==
X-Received: by 2002:a17:906:2e92:b0:a55:8200:c466 with SMTP id o18-20020a1709062e9200b00a558200c466mr5576859eji.39.1713773769958;
        Mon, 22 Apr 2024 01:16:09 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm1525648ejc.79.2024.04.22.01.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:16:09 -0700 (PDT)
Message-ID: <cf9109ac-f17b-4812-aa50-449b8fb9504e@kernel.org>
Date: Mon, 22 Apr 2024 10:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] can: Add LIN bus as CAN abstraction
To: Christoph Fritz <christoph.fritz@hexdev.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
 <20240422065114.3185505-2-christoph.fritz@hexdev.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240422065114.3185505-2-christoph.fritz@hexdev.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22. 04. 24, 8:51, Christoph Fritz wrote:
> This patch adds a LIN (local interconnect network) bus abstraction on
> top of CAN.  It is a glue driver adapting CAN on one side while offering
> LIN abstraction on the other side. So that upcoming LIN device drivers
> can make use of it.
...
> --- /dev/null
> +++ b/drivers/net/can/lin.c
...> +static int lin_create_sysfs_id_files(struct net_device *ndev)
> +{
> +	struct lin_device *ldev = netdev_priv(ndev);
> +	struct kobj_attribute *attr;
> +	int ret;
> +
> +	for (int id = 0; id < LIN_NUM_IDS; id++) {
> +		ldev->sysfs_entries[id].ldev = ldev;
> +		attr = &ldev->sysfs_entries[id].attr;
> +		attr->attr.name = kasprintf(GFP_KERNEL, "%02x", id);
> +		if (!attr->attr.name)
> +			return -ENOMEM;
> +		attr->attr.mode = 0644;
> +		attr->show = lin_identifier_show;
> +		attr->store = lin_identifier_store;
> +
> +		sysfs_attr_init(&attr->attr);
> +		ret = sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
> +		if (ret) {
> +			kfree(attr->attr.name);
> +			kfree(attr);

Is the latter kfree() right? It appears not.

> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
...
> +static void lin_tx_work_handler(struct work_struct *ws)
> +{
> +	struct lin_device *ldev = container_of(ws, struct lin_device,
> +					       tx_work);
> +	struct net_device *ndev = ldev->ndev;
> +	struct canfd_frame *cfd;
> +	struct lin_frame lf;
> +
> +	ldev->tx_busy = true;

How is this store protected against reordering/race conditions?

> +
> +	cfd = (struct canfd_frame *)ldev->tx_skb->data;
> +	lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
> +			   LINBUS_ENHANCED : LINBUS_CLASSIC;
> +	lf.lin_id = (u8)(cfd->can_id & LIN_ID_MASK);

Why is that cast necessary?

> +	lf.len = min(cfd->len, LIN_MAX_DLEN);
> +	memcpy(lf.data, cfd->data, lf.len);
> +
> +	ret = ldev->ldev_ops->ldo_tx(ldev, &lf);
> +	if (ret) {
> +		DEV_STATS_INC(ndev, tx_dropped);
> +		netdev_err_once(ndev, "transmission failure %d\n", ret);
> +		goto lin_tx_out;

Where is this label?

> +	}
> +
> +	DEV_STATS_INC(ndev, tx_packets);
> +	DEV_STATS_ADD(ndev, tx_bytes, lf.len);
> +	ldev->tx_busy = false;

The same as above.

> +	netif_wake_queue(ndev);
> +}
> +
> +static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
> +				  struct net_device *ndev)
> +{
> +	struct lin_device *ldev = netdev_priv(ndev);
> +
> +	if (ldev->tx_busy)
> +		return NETDEV_TX_BUSY;

And here too.

> +
> +	netif_stop_queue(ndev);
> +	ldev->tx_skb = skb;
> +	queue_work(ldev->wq, &ldev->tx_work);
> +
> +	return NETDEV_TX_OK;
> +}
...
> +u8 lin_get_checksum(u8 pid, u8 n_of_bytes, const u8 *bytes,
> +		    enum lin_checksum_mode cm)
> +{
> +	uint csum = 0;

Is "uint" of the preffered types in the kernel?

> +	int i;
> +
> +	if (cm == LINBUS_ENHANCED)
> +		csum += pid;
> +
> +	for (i = 0; i < n_of_bytes; i++) {
> +		csum += bytes[i];
> +		if (csum > 255)
> +			csum -= 255;
> +	}
> +
> +	return (u8)(~csum & 0xff);

Unnecessary cast?

> +}


> +int lin_rx(struct lin_device *ldev, const struct lin_frame *lf)
> +{
> +	struct net_device *ndev = ldev->ndev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	if (!ndev)
> +		return -ENODEV;

Is this racy or is this only a sanity check?

> +	netdev_dbg(ndev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> +		   lf->lin_id, lf->len, lf->len, lf->data, lf->checksum,
> +		   lf->checksum_mode ? "enhanced" : "classic");
> +
> +	ret = lin_bump_rx_err(ldev, lf);
> +	if (ret) {
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		return ret;
> +	}
> +
> +	skb = alloc_can_skb(ndev, &cf);
> +	if (unlikely(!skb)) {
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		return -ENOMEM;
> +	}
> +
> +	cf->can_id = lf->lin_id;
> +	cf->len = min(lf->len, LIN_MAX_DLEN);
> +	memcpy(cf->data, lf->data, cf->len);
> +
> +	DEV_STATS_INC(ndev, rx_packets);
> +	DEV_STATS_ADD(ndev, rx_bytes, cf->len);
> +
> +	netif_receive_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lin_rx);
> +
> +static int lin_set_bittiming(struct net_device *ndev)
> +{
> +	struct lin_device *ldev = netdev_priv(ndev);
> +	unsigned int bitrate;
> +	int ret;
> +
> +	bitrate = ldev->can.bittiming.bitrate;
> +	ret = ldev->ldev_ops->update_bitrate(ldev, bitrate);
> +
> +	return ret;

No need for ret then.

> +}
> +
> +static const u32 lin_bitrate[] = { 1200, 2400, 4800, 9600, 19200 };
> +
> +struct lin_device *register_lin(struct device *dev,
> +				const struct lin_device_ops *ldops)
> +{
> +	struct net_device *ndev;
> +	struct lin_device *ldev;
> +	int ret;
> +
> +	if (!ldops || !ldops->ldo_tx || !ldops->update_bitrate) {
> +		netdev_err(ndev, "missing mandatory lin_device_ops\n");
> +		return ERR_PTR(-EOPNOTSUPP);

Would EINVAL fit better?

> +	}
> +
> +	ndev = alloc_candev(sizeof(struct lin_device), 1);
> +	if (!ndev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ldev = netdev_priv(ndev);
> +
> +	ldev->ldev_ops = ldops;
> +	ndev->netdev_ops = &lin_netdev_ops;
> +	ndev->flags |= IFF_ECHO;
> +	ndev->mtu = CANFD_MTU;
> +	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
> +	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
> +	ldev->can.ctrlmode_supported = 0;
> +	ldev->can.bitrate_const = lin_bitrate;
> +	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
> +	ldev->can.do_set_bittiming = lin_set_bittiming;
> +	ldev->ndev = ndev;
> +	ldev->dev = dev;
> +
> +	SET_NETDEV_DEV(ndev, dev);
> +
> +	ret = lin_set_bittiming(ndev);
> +	if (ret) {
> +		netdev_err(ndev, "set bittiming failed\n");
> +		goto exit_candev;
> +	}
> +
> +	ret = register_candev(ndev);
> +	if (ret)
> +		goto exit_candev;
> +
> +	ldev->lin_ids_kobj = kobject_create_and_add("lin_ids", &ndev->dev.kobj);
> +	if (!ldev->lin_ids_kobj) {
> +		netdev_err(ndev, "Failed to create sysfs directory\n");
> +		ret = -ENOMEM;
> +		goto exit_unreg;
> +	}
> +
> +	ret = lin_create_sysfs_id_files(ndev);
> +	if (ret) {
> +		netdev_err(ndev, "Failed to create sysfs entry: %d\n", ret);
> +		goto exit_kobj_put;
> +	}
> +
> +	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
> +				   0);

It would be worth noting why you need your own WQ.

> +	if (!ldev->wq)
> +		goto exit_rm_files;
> +
> +	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
> +
> +	netdev_info(ndev, "LIN initialized.\n");
> +
> +	return ldev;
> +
> +exit_rm_files:
> +	lin_remove_sysfs_id_files(ndev);
> +exit_kobj_put:
> +	kobject_put(ldev->lin_ids_kobj);
> +exit_unreg:
> +	unregister_candev(ndev);
> +exit_candev:
> +	free_candev(ndev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(register_lin);
> +
> +void unregister_lin(struct lin_device *ldev)
> +{
> +	struct net_device *ndev = ldev->ndev;
> +
> +	lin_remove_sysfs_id_files(ndev);
> +	kobject_put(ldev->lin_ids_kobj);
> +	unregister_candev(ndev);
> +	destroy_workqueue(ldev->wq);
> +	free_candev(ndev);
> +}
> +EXPORT_SYMBOL_GPL(unregister_lin);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> +MODULE_DESCRIPTION("LIN bus to CAN glue driver");
> diff --git a/include/net/lin.h b/include/net/lin.h
> new file mode 100644
> index 0000000000000..2fe16e142db96
> --- /dev/null
> +++ b/include/net/lin.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> +
> +#ifndef _NET_LIN_H_
> +#define _NET_LIN_H_
> +
> +#include <linux/can/dev.h>
> +#include <linux/device.h>
> +
> +#define LIN_NUM_IDS		64
> +#define LIN_HEADER_SIZE		3
> +#define LIN_MAX_DLEN		8
> +
> +#define LIN_MAX_BAUDRATE	20000
> +#define LIN_MIN_BAUDRATE	1000
> +#define LIN_DEFAULT_BAUDRATE	9600
> +#define LIN_SYNC_BYTE		0x55
> +
> +#define LIN_ID_MASK		0x0000003FU

GEN_MASK() ?

> +/* special ID descriptions for LIN */
> +#define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
> +
> +static const unsigned char lin_id_parity_tbl[] = {

This ends up in every translation unit you include lin.h into. Bad.

And perhaps u8?

> +	0x80, 0xc0, 0x40, 0x00, 0xc0, 0x80, 0x00, 0x40,
> +	0x00, 0x40, 0xc0, 0x80, 0x40, 0x00, 0x80, 0xc0,
> +	0x40, 0x00, 0x80, 0xc0, 0x00, 0x40, 0xc0, 0x80,
> +	0xc0, 0x80, 0x00, 0x40, 0x80, 0xc0, 0x40, 0x00,
> +	0x00, 0x40, 0xc0, 0x80, 0x40, 0x00, 0x80, 0xc0,
> +	0x80, 0xc0, 0x40, 0x00, 0xc0, 0x80, 0x00, 0x40,
> +	0xc0, 0x80, 0x00, 0x40, 0x80, 0xc0, 0x40, 0x00,
> +	0x40, 0x00, 0x80, 0xc0, 0x00, 0x40, 0xc0, 0x80,
> +};
> +
> +#define LIN_GET_ID(PID)		((PID) & LIN_ID_MASK)

FIELD_GET() ?

> +#define LIN_FORM_PID(ID)	(LIN_GET_ID(ID) | \
> +					lin_id_parity_tbl[LIN_GET_ID(ID)])
> +#define LIN_GET_PARITY(PID)	((PID) & ~LIN_ID_MASK)
> +#define LIN_CHECK_PID(PID)	(LIN_GET_PARITY(PID) == \
> +					LIN_GET_PARITY(LIN_FORM_PID(PID)))

thanks,
-- 
js
suse labs


