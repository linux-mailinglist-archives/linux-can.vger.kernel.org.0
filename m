Return-Path: <linux-can+bounces-599-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3A8BFD9A
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCFF1F2181E
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059526A33B;
	Wed,  8 May 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="FHDSzPwN"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DA50A7E;
	Wed,  8 May 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172468; cv=none; b=V1mLnGI8VRJTu9KEw/edNFXWse47T6spqPZJRKBI975s2q0lP2xxKWGEBu1dP47Vz59YqCmZea618gxwMs0hc+o3DQ+ObUMaUFCskFHyM7Pig6sucjk3poH491B+fzsZTq9QYq3woLHhq6SaPFPvjXEHEN59pbDSU1NFeUnn5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172468; c=relaxed/simple;
	bh=WPyi3SXFa6tQ0I3B1sOmV/iwAsDxSq2wRIcmLfLGteI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOIOxclKdVHNihiHeWDvCRm16eTv3zAy90IHb1Vj4dLFus+LXqXXlYALgksaueW+fOvf/lvhD+ihgrC6pMoDm5dgNEsjxhoj41UI8d/HyEglDaHJ/e4tZscDxBVixUSuXcTSrSYzrcWvhy0+2ws4+3GSJrDWqETPi8+uAW0GH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=FHDSzPwN; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Fr91Ri94RCEVnvc4RJ3UBX9Nrt7VQguTPYT2HEiuM5g=; b=FHDSzPwN2eZwJOrDjDMn8I12Yv
	iqOFRPwaIXfun7wBBx89veyNR80dHrAlWnEBtKmyU65L0sP1pHd97cBq8/BeUa2wrfJ0w1RuaW0QX
	IKtV+hzjRz4N0xWVshJdqIrgNqQmZZDNV3w2tj9LBpHVflvXIux9XtSZYBr6AGbwvhMQ=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4ghe-001hoe-1x;
	Wed, 08 May 2024 14:47:23 +0200
Message-ID: <e0f3d0716ed2f4281561f08bbcd3050dddcf1831.camel@hexdev.de>
Subject: Re: [PATCH v3 01/11] can: Add LIN bus as CAN abstraction
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel
 <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Wed, 08 May 2024 14:47:19 +0200
In-Reply-To: <61adf428-2205-1563-d0b6-fa843e08559d@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-2-christoph.fritz@hexdev.de>
	 <61adf428-2205-1563-d0b6-fa843e08559d@linux.intel.com>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-06 at 19:24 +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Christoph Fritz wrote:
> 
> > This patch adds a LIN (local interconnect network) bus abstraction on
> > top of CAN.  It is a glue driver adapting CAN on one side while offering
> > LIN abstraction on the other side. So that upcoming LIN device drivers
> > can make use of it.
...
> > +static ssize_t lin_identifier_show(struct kobject *kobj,
> > +				   struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct lin_attr *lin_attr = container_of(attr, struct lin_attr, attr);
> > +	struct lin_device *ldev = lin_attr->ldev;
> > +	ssize_t count = 0;
> > +	struct lin_responder_answer answ;
> > +	int k, ret;
> > +	long id;
> > +
> > +	if (!ldev->ldev_ops->get_responder_answer)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = kstrtol(attr->attr.name, 16, &id);
> > +	if (ret)
> > +		return ret;
> > +	if (id < 0 || id >= LIN_NUM_IDS)
> > +		return -EINVAL;
> > +
> > +	count += scnprintf(buf + count, PAGE_SIZE - count,
> > +			   "%-6s %-11s %-9s %-9s %-2s %-24s %-6s\n",
> > +			   "state", "cksum-mode", "is_event", "event_id",
> > +			   "n", "data", "cksum");
> 
> Onl use sysfs_emit() and sysfs_emit_at() in *_show functions.

OK

> > +
> > +	ret = ldev->ldev_ops->get_responder_answer(ldev, id, &answ);
> > +	if (ret)
> > +		return ret;
> > +
> > +	count += scnprintf(buf + count, PAGE_SIZE - count,
> > +			   "%-6s %-11s %-9s %-9u %-2u ",
> > +			   answ.is_active ? "active" : "off",
> > +			   answ.lf.checksum_mode ? "enhanced" : "classic",
> > +			   answ.is_event_frame ? "yes" : "no",
> > +			   answ.event_associated_id,
> > +			   answ.lf.len);
> > +
> > +	for (k = 0; k < answ.lf.len; k++)
> > +		count += scnprintf(buf + count, PAGE_SIZE - count,
> > +				   "%02x ", answ.lf.data[k]);
> > +	for (; k < 8; k++)
> > +		count += scnprintf(buf + count, PAGE_SIZE - count,
> > +				   "   ");
> > +	if (answ.lf.len)
> > +		count += scnprintf(buf + count, PAGE_SIZE - count,
> > +				   " %02x", answ.lf.checksum);
> > +
> > +	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
> > +
> > +	return count;
> > +}
...
> > +
> > +static int lin_create_sysfs_id_files(struct net_device *ndev)
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
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Can you use .dev_groups instead ?

I'm not sure where to attach this in this glue code here. Should I do a
class_register() and add the .dev_groups there?

> FWIW, this function doesn't do rollback when error occurs.

OK, this issue can be fixed in revision v4.

...
> > diff --git a/include/net/lin.h b/include/net/lin.h
> > new file mode 100644
> > index 0000000000000..e7c7c820a6e18
> > --- /dev/null
> > +++ b/include/net/lin.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> > +
> > +#ifndef _NET_LIN_H_
> > +#define _NET_LIN_H_
> > +
> > +#include <linux/bitfield.h>
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
> > +#define LIN_ID_MASK		GENMASK(5, 0)
> > +/* special ID descriptions for LIN */
> > +#define LIN_RXOFFLOAD_DATA_FLAG	0x00000200U
> > +#define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
> 
> BIT(x) x 2

OK

> 
> > +
> > +extern u8 lin_get_id_parity(u8 id);
> > +
> > +#define LIN_GET_ID(PID)		FIELD_GET(LIN_ID_MASK, PID)
> > +#define LIN_FORM_PID(ID)	(LIN_GET_ID(ID) | \
> > +					lin_get_id_parity(LIN_GET_ID(ID)))
> > +#define LIN_GET_PARITY(PID)	((PID) & ~LIN_ID_MASK)
> > +#define LIN_CHECK_PID(PID)	(LIN_GET_PARITY(PID) == \
> > +					LIN_GET_PARITY(LIN_FORM_PID(PID)))
> > +
> > +struct lin_attr {
> > +	struct kobj_attribute attr;
> > +	struct lin_device *ldev;
> > +};
> > +
> > +struct lin_device {
> > +	struct can_priv can;  /* must be the first member */
> > +	struct net_device *ndev;
> > +	struct device *dev;
> > +	const struct lin_device_ops *ldev_ops;
> > +	struct workqueue_struct *wq;
> > +	struct work_struct tx_work;
> > +	bool tx_busy;
> > +	struct sk_buff *tx_skb;
> > +	struct kobject *lin_ids_kobj;
> > +	struct lin_attr sysfs_entries[LIN_NUM_IDS];
> > +};
> > +
> > +enum lin_checksum_mode {
> > +	LINBUS_CLASSIC = 0,
> > +	LINBUS_ENHANCED,
> > +};
> > +
> > +struct lin_frame {
> > +	u8 lin_id;
> > +	u8 len;
> > +	u8 data[LIN_MAX_DLEN];
> > +	u8 checksum;
> > +	enum lin_checksum_mode checksum_mode;
> > +};
> > +
> > +struct lin_responder_answer {
> > +	bool is_active;
> > +	bool is_event_frame;
> > +	u8 event_associated_id;
> > +	struct lin_frame lf;
> > +};
> > +
> > +struct lin_device_ops {
> > +	int (*ldo_open)(struct lin_device *ldev);
> > +	int (*ldo_stop)(struct lin_device *ldev);
> > +	int (*ldo_tx)(struct lin_device *ldev, const struct lin_frame *frame);
> > +	int (*update_bitrate)(struct lin_device *ldev, u16 bitrate);
> > +	int (*update_responder_answer)(struct lin_device *ldev,
> > +				       const struct lin_responder_answer *answ);
> > +	int (*get_responder_answer)(struct lin_device *ldev, u8 id,
> > +				    struct lin_responder_answer *answ);
> > +};
> > +
> > +int lin_rx(struct lin_device *ldev, const struct lin_frame *lf);
> > +
> > +u8 lin_get_checksum(u8 pid, u8 n_of_bytes, const u8 *bytes,
> > +		    enum lin_checksum_mode cm);
> > +
> > +struct lin_device *register_lin(struct device *dev,
> > +				const struct lin_device_ops *ldops);
> > +void unregister_lin(struct lin_device *ldev);
> > +
> > +#endif /* _NET_LIN_H_ */
> > diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> > index 02ec32d694742..51b0e2a7624e4 100644
> > --- a/include/uapi/linux/can/netlink.h
> > +++ b/include/uapi/linux/can/netlink.h
> > @@ -103,6 +103,7 @@ struct can_ctrlmode {
> >  #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
> >  #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
> >  #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
> 
> BIT(x) is these days available also for uapi I think.
> 
> > +#define CAN_CTRLMODE_LIN		0x800	/* LIN bus mode */

So, should I use just BIT(11) for the new define, or should I also
refactor the whole list while at it?

Thanks
  -- Christoph

