Return-Path: <linux-can+bounces-585-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C38BD338
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B4E1F264EF
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF901156C69;
	Mon,  6 May 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC5+8DX7"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EE156962;
	Mon,  6 May 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014456; cv=none; b=XNxxGvRcRszU3g1LiNRKNO6pASCAi1qf6UTXF4OP2m48SIQAFgqag//VmNBU4z6demvXkgYtsVdZAWYrhTQD2SjSsu7iXRWWcRuFvSZxjh+auG/FgsHKlFaOI4gdTonX4cnul5Jzmi3k/EBgzG+5J6G7TKg3P+vWH1ETAeaCSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014456; c=relaxed/simple;
	bh=AF7ivyCt8XgVn0CiWt87U3x4qxm2OZmcRUPtzHXchjQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GcDQK7VmYLuPzMDiMqaU7PfFEmlXDMaNXXwJCcbakAbuLcJi/WU29hlhhskrnanpRLnXzDIqOilMXOtAw3STKy8y3/y0GE0a0h2S4gui5YTgDBdiPj2ed2iOdZu3zO3gq3AEwCgShwDCgfaF1LXeF1xBxk6D4tpnUu01UknR3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC5+8DX7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715014454; x=1746550454;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AF7ivyCt8XgVn0CiWt87U3x4qxm2OZmcRUPtzHXchjQ=;
  b=YC5+8DX7C/OKb8K1gS7eXIylNdXvUBQvXyiFOwBPfYWwGZZKyFSK8F83
   A500prTgUNDFDytBXxM+zKmZ/4u2sZ9nzv20UnmG4NP5JqZkTgOKzXBx+
   Z4Gll9BFBQqDRuVV5QO6L5i5rkHe5JtsSFiSwGJyItO1vIeie8hG0i/gM
   Mawb+7J0YAZj02qUeTsBuFroDeWxTvhptddX8w5xg9/dMeFpwH939PzeX
   KkYqgDvZ1fixx7trHbuHzrGkrrVUAb9fc6BbLxBIgz5OsCLBqkhMaex0t
   VGvV3Hmt7ashk0O6GaUtNwHxrliQE4at7hEJQbQEeEtPgZXt5xDO96ARE
   g==;
X-CSE-ConnectionGUID: 10d3/qS4Sz6v4iq1yg1QNA==
X-CSE-MsgGUID: hIWq2kGfQc+kDXM6hwt1kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13721645"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="13721645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 09:54:09 -0700
X-CSE-ConnectionGUID: VjL41DnKS1+jZpovNiK+Hw==
X-CSE-MsgGUID: 23A3P6qKQSW9v3GTy/kDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32888332"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 09:54:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 19:53:56 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] HID: hexLIN: Add support for USB LIN bus
 adapter
In-Reply-To: <20240502182804.145926-3-christoph.fritz@hexdev.de>
Message-ID: <422e0d3a-3eb9-ff78-8419-56e894e04137@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de> <20240502182804.145926-3-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, Christoph Fritz wrote:

> This patch introduces driver support for the hexLIN USB LIN bus adapter,
> enabling LIN communication over USB for both controller and responder
> modes. The driver interfaces with the CAN_LIN framework for userland
> connectivity.
> 
> For more details on the adapter, visit: https://hexdev.de/hexlin/
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/hid/Kconfig             |  19 +
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-hexdev-hexlin.c | 611 ++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h           |   1 +
>  drivers/hid/hid-quirks.c        |   3 +
>  5 files changed, 635 insertions(+)
>  create mode 100644 drivers/hid/hid-hexdev-hexlin.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4c682c6507040..d2fb35d83c640 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -496,6 +496,25 @@ config HID_GYRATION
>  	help
>  	Support for Gyration remote control.
>  
> +config HID_MCS_HEXDEV
> +	tristate "hexDEV LIN-BUS adapter support"
> +	depends on HID && CAN_NETLINK && CAN_DEV
> +	select CAN_LIN
> +	help
> +	  Support for hexDEV its hexLIN USB LIN bus adapter.
> +
> +	  Local Interconnect Network (LIN) to USB adapter for controller and
> +	  responder usage.
> +	  This device driver is using CAN_LIN for a userland connection on
> +	  one side and USB HID for the actual hardware adapter on the other
> +	  side.
> +
> +	  If you have such an adapter, say Y here and see
> +	  <https://hexdev.de/hexlin>.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-hexlin.
> +
>  config HID_ICADE
>  	tristate "ION iCade arcade controller"
>  	help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 082a728eac600..f9b13e6117e60 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
>  obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
>  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
> +obj-$(CONFIG_HID_MCS_HEXDEV)	+= hid-hexdev-hexlin.o
>  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
>  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
>  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
> diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
> new file mode 100644
> index 0000000000000..1ddc1e00ab2da
> --- /dev/null
> +++ b/drivers/hid/hid-hexdev-hexlin.c
> @@ -0,0 +1,611 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * LIN bus USB adapter driver https://hexdev.de/hexlin
> + *
> + * Copyright (C) 2024 hexDEV GmbH
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/wait.h>
> +#include <net/lin.h>
> +#include "hid-ids.h"
> +
> +enum {
> +	/* answers */
> +	HEXLIN_SUCCESS = 0x01,
> +	HEXLIN_FRAME = 0x02,
> +	HEXLIN_ERROR = 0x03,
> +	HEXLIN_FAIL = 0x0F,
> +
> +	/* lin-responder */
> +	HEXLIN_SET_MODE_RESPONDER = 0x10,
> +	HEXLIN_SET_RESPONDER_ANSWER_ID = 0x11,
> +	HEXLIN_GET_RESPONDER_ANSWER_ID = 0x12,
> +
> +	/* lin-controller */
> +	HEXLIN_SET_MODE_CONTROLLER = 0x20,
> +	HEXLIN_SEND_BREAK = 0x21,
> +	HEXLIN_SEND_UNCONDITIONAL_FRAME = 0x22,
> +
> +	/* lin-div */
> +	HEXLIN_SET_BAUDRATE = 0x34,
> +	HEXLIN_GET_BAUDRATE = 0x35,
> +
> +	/* div */
> +	HEXLIN_RESET = 0xF0,
> +	HEXLIN_GET_VERSION = 0xF1,

Could you align the values?

> +};
> +
> +#define HEXLIN_SUCCESS_SZ			1
> +#define HEXLIN_FRAME_SZ				17
> +#define HEXLIN_FAIL_SZ				1
> +#define HEXLIN_GET_RESPONDER_ANSWER_ID_SZ	20
> +#define HEXLIN_GET_BAUDRATE_SZ			3

Is this sizeof(hexlin_baudrate_req)? If so, don't add define for it.
This probably applies to other defines here too.

> +#define HEXLIN_BAUDRATE_SZ			2
> +#define HEXLIN_GET_VERSION_SZ			2
> +#define HEXLIN_PKGLEN_MAX_SZ			64
> +
> +struct hexlin_val8_req {
> +	u8 cmd;
> +	u8 v;
> +} __packed;
> +
> +struct hexlin_baudrate_req {
> +	u8 cmd;
> +	u16 baudrate;
> +} __packed;
> +
> +struct hexlin_frame {
> +	u32 flags;
> +	u8 len;
> +	u8 lin_id;
> +	u8 data[LIN_MAX_DLEN];
> +	u8 checksum;
> +	u8 checksum_mode;
> +} __packed;
> +
> +struct hexlin_unconditional_req {
> +	u8 cmd;
> +	struct hexlin_frame frm;
> +} __packed;
> +
> +struct hexlin_responder_answer {
> +	u8 is_active;
> +	u8 is_event_frame;
> +	u8 event_associated_id;
> +	struct hexlin_frame frm;
> +} __packed;
> +
> +struct hexlin_responder_answer_req {
> +	u8 cmd;
> +	struct hexlin_responder_answer answ;
> +} __packed;
> +
> +struct hexlin_priv_data {
> +	struct hid_device *hid_dev;
> +	struct lin_device *ldev;
> +	u16 baudrate;
> +	struct completion wait_in_report;
> +	bool is_error;
> +	struct mutex tx_lock;  /* protects hexlin_tx_report() */
> +	struct hexlin_responder_answer_req rar;
> +	u8 fw_version;
> +};
> +
> +static int hexlin_tx_report(struct hexlin_priv_data *priv,
> +			    const void *out_report, size_t len)
> +{
> +	u8 *buf;
> +	int ret;
> +
> +	buf = kmemdup(out_report, len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = hid_hw_output_report(priv->hid_dev, buf, len);
> +	kfree(buf);

Is duplicatign the buffer necessary?

> +	if (ret < 0)
> +		return ret;
> +	if (ret != len)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int hexlin_tx_req_status(struct hexlin_priv_data *priv,
> +				const void *out_report, int len)
> +{
> +	int ret;
> +	unsigned long t;
> +
> +	mutex_lock(&priv->tx_lock);
> +
> +	reinit_completion(&priv->wait_in_report);
> +
> +	ret = hexlin_tx_report(priv, out_report, len);
> +	if (ret)
> +		goto tx_exit;
> +
> +	t = wait_for_completion_killable_timeout(&priv->wait_in_report,
> +						 msecs_to_jiffies(1000));

HZ?

> +	if (!t)
> +		ret = -ETIMEDOUT;
> +
> +	if (priv->is_error)
> +		ret = -EINVAL;
> +
> +tx_exit:
> +	mutex_unlock(&priv->tx_lock);
> +
> +	return ret;
> +}
> +
> +#define HEXLIN_GET_CMD(name, enum_cmd)					\
> +	static int hexlin_##name(struct hexlin_priv_data *priv)		\
> +	{								\
> +		u8 cmd = enum_cmd;					\
> +		int ret;						\
> +									\
> +		ret = hexlin_tx_req_status(priv, &cmd, sizeof(u8));	\

Take sizeof() of the relevant variable instead, so:

sizeof(cmd)

> +		if (ret)						\
> +			hid_err(priv->hid_dev, "%s failed with %d\n",	\
> +				__func__, ret);				\
> +									\
> +		return ret;						\
> +	}
> +
> +HEXLIN_GET_CMD(get_version, HEXLIN_GET_VERSION)
> +HEXLIN_GET_CMD(reset_dev, HEXLIN_RESET)
> +HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
> +
> +#define HEXLIN_VAL_CMD(name, enum_cmd, struct_type, vtype)		\
> +	static int hexlin_##name(struct hexlin_priv_data *p, vtype val)	\
> +	{								\
> +		struct struct_type req;					\
> +		int ret;						\
> +									\
> +		req.cmd = enum_cmd;					\
> +		req.v = val;						\
> +									\
> +		ret = hexlin_tx_req_status(p, &req,			\
> +					   sizeof(struct struct_type));	\

sizeof(req)

> +		if (ret)						\
> +			hid_err(p->hid_dev, "%s failed with %d\n",	\
> +				__func__, ret);				\
> +									\
> +		return ret;						\
> +	}
> +
> +HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
> +
> +static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
> +				      const u8 *raw_data, int sz)
> +{
> +	struct hid_device *hdev = priv->hid_dev;
> +	struct hexlin_frame hxf;
> +	struct lin_frame lf;
> +
> +	if (sz != sizeof(struct hexlin_frame))
> +		return -EREMOTEIO;
> +
> +	memcpy(&hxf, raw_data, sz);

Why you cannot just cast the pointer to correct type?

> +	le32_to_cpus(hxf.flags);

You must use correct endianess typing. The struct hexlin_frame should have 
__le32 flags so sparse's endianness check is happy.

But .flags are not used at all so why is this required in the first place?

> +	lf.len = hxf.len;
> +	lf.lin_id = hxf.lin_id;
> +	memcpy(lf.data, hxf.data, LIN_MAX_DLEN);
> +	lf.checksum = hxf.checksum;
> +	lf.checksum_mode = hxf.checksum_mode;
> +
> +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> +		   lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> +		   lf.checksum_mode ? "enhanced" : "classic");
> +
> +	lin_rx(priv->ldev, &lf);
> +
> +	return 0;
> +}
> +
> +static int hexlin_send_unconditional(struct hexlin_priv_data *priv,
> +			      const struct hexlin_frame *hxf)
> +{
> +	struct hexlin_unconditional_req req;
> +	int ret;
> +
> +	if (hxf->lin_id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	req.cmd = HEXLIN_SEND_UNCONDITIONAL_FRAME;
> +	memcpy(&req.frm, hxf, sizeof(struct hexlin_frame));
> +
> +	ret = hexlin_tx_req_status(priv, &req,
> +				   sizeof(struct hexlin_unconditional_req));

sizeof(req)

> +
> +	if (ret)
> +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int hexlin_set_baudrate(struct hexlin_priv_data *priv, u16 baudrate)
> +{
> +	struct hexlin_baudrate_req req;
> +	int ret;
> +
> +	if (baudrate < LIN_MIN_BAUDRATE || baudrate > LIN_MAX_BAUDRATE)
> +		return -EINVAL;
> +
> +	req.cmd = HEXLIN_SET_BAUDRATE;
> +	req.baudrate = cpu_to_le16(baudrate);

The struct should have __le16 baudrate.

> +
> +	ret = hexlin_tx_req_status(priv, &req,
> +				   sizeof(struct hexlin_baudrate_req));
> +	if (ret)
> +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int hexlin_get_responder_answer_id(struct hexlin_priv_data *priv, u8 id,
> +					  struct hexlin_responder_answer_req *rar)
> +{
> +	u8 req[2] = { HEXLIN_GET_RESPONDER_ANSWER_ID, id };
> +	int ret;
> +
> +	if (id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	ret = hexlin_tx_req_status(priv, &req, sizeof(req));
> +	if (ret) {
> +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);

Try to write error message that is meaningful to user, printing __func__ 
is not very helpful for user.

> +		return ret;
> +	}
> +
> +	memcpy(rar, &priv->rar, sizeof(struct hexlin_responder_answer_req));

sizeof(*rar)

> +	return 0;
> +}
> +
> +static int hexlin_set_responder_answer_id(struct hexlin_priv_data *priv,
> +					  const struct lin_responder_answer *answ)
> +{
> +	struct hexlin_responder_answer_req rar;
> +	int ret;
> +
> +	if (answ->lf.lin_id > LIN_ID_MASK ||
> +	    answ->event_associated_id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	rar.cmd = HEXLIN_SET_RESPONDER_ANSWER_ID;
> +	rar.answ.is_active = answ->is_active;
> +	rar.answ.is_event_frame = answ->is_event_frame;
> +	rar.answ.event_associated_id = answ->event_associated_id;
> +	rar.answ.frm.len = answ->lf.len;
> +	rar.answ.frm.lin_id = answ->lf.lin_id;
> +	memcpy(rar.answ.frm.data, answ->lf.data, LIN_MAX_DLEN);
> +	rar.answ.frm.checksum = answ->lf.checksum;
> +	rar.answ.frm.checksum_mode = answ->lf.checksum_mode;
> +
> +	ret = hexlin_tx_req_status(priv, &rar,
> +				   sizeof(struct hexlin_responder_answer_req));

Ditto.

-- 
 i.


> +	if (ret)
> +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int hexlin_open(struct lin_device *ldev)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +
> +	return hid_hw_open(hdev);
> +}
> +
> +static int hexlin_stop(struct lin_device *ldev)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +
> +	hid_hw_close(hdev);
> +
> +	priv->is_error = true;
> +	complete(&priv->wait_in_report);
> +
> +	return 0;
> +}
> +
> +static int hexlin_ldo_tx(struct lin_device *ldev,
> +			 const struct lin_frame *lf)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +	int ret = -EINVAL;
> +
> +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> +		   lf->lin_id, lf->len, lf->len, lf->data, lf->checksum,
> +		   lf->checksum_mode ? "enhanced" : "classic");
> +
> +	if (lf->lin_id && lf->len == 0) {
> +		ret = hexlin_send_break(priv, lf->lin_id);
> +	} else if (lf->len <= LIN_MAX_DLEN) {
> +		struct hexlin_frame hxf;
> +
> +		hxf.len = lf->len;
> +		hxf.lin_id = lf->lin_id;
> +		memcpy(&hxf.data, lf->data, LIN_MAX_DLEN);
> +		hxf.checksum = lf->checksum;
> +		hxf.checksum_mode = lf->checksum_mode;
> +		ret = hexlin_send_unconditional(priv, &hxf);
> +	} else {
> +		hid_err(hdev, "unknown format\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int hexlin_update_bitrate(struct lin_device *ldev, u16 bitrate)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +	int ret;
> +
> +	hid_dbg(hdev, "update bitrate to: %u\n", bitrate);
> +
> +	ret = hexlin_open(ldev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hexlin_set_baudrate(priv, bitrate);
> +	if (ret)
> +		return ret;
> +
> +	ret = hexlin_get_baudrate(priv);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->baudrate != bitrate) {
> +		hid_err(hdev, "update bitrate failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int hexlin_get_responder_answer(struct lin_device *ldev, u8 id,
> +				       struct lin_responder_answer *answ)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +	struct hexlin_responder_answer_req rar;
> +	int ret;
> +
> +	if (answ == NULL)
> +		return -EINVAL;
> +
> +	ret = hexlin_get_responder_answer_id(priv, id, &rar);
> +	if (ret)
> +		return ret;
> +
> +	answ->is_active = rar.answ.is_active;
> +	answ->is_event_frame = rar.answ.is_event_frame;
> +	answ->event_associated_id = rar.answ.event_associated_id;
> +	answ->lf.len = rar.answ.frm.len;
> +	answ->lf.lin_id = rar.answ.frm.lin_id;
> +	memcpy(answ->lf.data, rar.answ.frm.data, LIN_MAX_DLEN);
> +	answ->lf.checksum = rar.answ.frm.checksum;
> +	answ->lf.checksum_mode = rar.answ.frm.checksum_mode;
> +
> +	return 0;
> +}
> +
> +static int hexlin_update_resp_answer(struct lin_device *ldev,
> +				     const struct lin_responder_answer *answ)
> +{
> +	struct hid_device *hdev = to_hid_device(ldev->dev);
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +
> +	if (answ == NULL)
> +		return -EINVAL;
> +
> +	return hexlin_set_responder_answer_id(priv, answ);
> +}
> +
> +static const struct lin_device_ops hexlin_ldo = {
> +	.ldo_open = hexlin_open,
> +	.ldo_stop = hexlin_stop,
> +	.ldo_tx = hexlin_ldo_tx,
> +	.update_bitrate = hexlin_update_bitrate,
> +	.get_responder_answer = hexlin_get_responder_answer,
> +	.update_responder_answer = hexlin_update_resp_answer,
> +};
> +
> +static int hexlin_raw_event(struct hid_device *hdev,
> +			    struct hid_report *report, u8 *data, int sz)
> +{
> +	struct hexlin_priv_data *priv;
> +	int ret;
> +
> +	if (sz < 1 || sz > HEXLIN_PKGLEN_MAX_SZ)
> +		return -EREMOTEIO;
> +
> +	priv = hid_get_drvdata(hdev);
> +
> +	hid_dbg(hdev, "%s, size:%i, data[0]: 0x%02x\n", __func__, sz, data[0]);
> +
> +	priv->is_error = false;
> +
> +	switch (data[0]) {
> +	case HEXLIN_SUCCESS:
> +		if (sz != HEXLIN_SUCCESS_SZ)
> +			return -EREMOTEIO;
> +		hid_dbg(hdev, "HEXLIN_SUCCESS: 0x%02x\n", data[0]);
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_FAIL:
> +		if (sz != HEXLIN_FAIL_SZ)
> +			return -EREMOTEIO;
> +		hid_err(hdev, "HEXLIN_FAIL: 0x%02x\n", data[0]);
> +		priv->is_error = true;
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_VERSION:
> +		if (sz != HEXLIN_GET_VERSION_SZ)
> +			return -EREMOTEIO;
> +		priv->fw_version = data[1];
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_RESPONDER_ANSWER_ID:
> +		if (sz != HEXLIN_GET_RESPONDER_ANSWER_ID_SZ)
> +			return -EREMOTEIO;
> +		BUILD_BUG_ON(sizeof(priv->rar) !=
> +			HEXLIN_GET_RESPONDER_ANSWER_ID_SZ);
> +		memcpy(&priv->rar, data, sizeof(priv->rar));
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_BAUDRATE:
> +		if (sz != HEXLIN_GET_BAUDRATE_SZ)
> +			return -EREMOTEIO;
> +		BUILD_BUG_ON(sizeof(priv->baudrate) != HEXLIN_BAUDRATE_SZ);
> +		memcpy(&priv->baudrate, &data[1], sizeof(priv->baudrate));
> +		le16_to_cpus(priv->baudrate);
> +		complete(&priv->wait_in_report);
> +		break;
> +	/* following cases not initiated by us, so no complete() */
> +	case HEXLIN_FRAME:
> +		if (sz != HEXLIN_FRAME_SZ) {
> +			hid_err_once(hdev, "frame size mismatch: %i\n", sz);
> +			return -EREMOTEIO;
> +		}
> +		ret = hexlin_queue_frames_insert(priv, &data[1], sz-1);
> +		if (ret) {
> +			hid_err(hdev, "failed to add frame: %i\n", ret);
> +			return ret;
> +		}
> +		break;
> +	case HEXLIN_ERROR:
> +		hid_err(hdev, "error from adapter\n");
> +		break;
> +	default:
> +		hid_err(hdev, "unknown event: 0x%02x\n", data[0]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int init_hw(struct hexlin_priv_data *priv)
> +{
> +	int ret;
> +
> +	ret = hexlin_reset_dev(priv);
> +	if (ret) {
> +		/* if first reset fails, try one more time */
> +		ret = hexlin_reset_dev(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = hexlin_get_version(priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->baudrate = LIN_DEFAULT_BAUDRATE;
> +	ret = hexlin_set_baudrate(priv, priv->baudrate);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int hexlin_probe(struct hid_device *hdev,
> +			const struct hid_device_id *id)
> +{
> +	struct hexlin_priv_data *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->hid_dev = hdev;
> +	hid_set_drvdata(hdev, priv);
> +
> +	mutex_init(&priv->tx_lock);
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid parse failed with %d\n", ret);
> +		goto fail_and_free;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DRIVER);
> +	if (ret) {
> +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> +		goto fail_and_close;
> +	}
> +
> +	init_completion(&priv->wait_in_report);
> +
> +	hid_device_io_start(hdev);
> +
> +	ret = init_hw(priv);
> +	if (ret)
> +		goto fail_and_close;
> +
> +	priv->ldev = register_lin(&hdev->dev, &hexlin_ldo);
> +	if (IS_ERR_OR_NULL(priv->ldev)) {
> +		ret = PTR_ERR(priv->ldev);
> +		goto fail_and_close;
> +	}
> +
> +	hid_hw_close(hdev);
> +
> +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);
> +
> +	return 0;
> +
> +fail_and_close:
> +	hid_hw_close(hdev);
> +fail_and_stop:
> +	hid_hw_stop(hdev);
> +fail_and_free:
> +	mutex_destroy(&priv->tx_lock);
> +	return ret;
> +}
> +
> +static void hexlin_remove(struct hid_device *hdev)
> +{
> +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> +
> +	unregister_lin(priv->ldev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id hexlin_table[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_HEXDEV_HEXLIN) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(hid, hexlin_table);
> +
> +static struct hid_driver hexlin_driver = {
> +	.name = "hexLIN",
> +	.id_table = hexlin_table,
> +	.probe = hexlin_probe,
> +	.remove = hexlin_remove,
> +	.raw_event = hexlin_raw_event,
> +};
> +
> +module_hid_driver(hexlin_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> +MODULE_DESCRIPTION("LIN bus driver for hexLIN USB adapter");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 64164423b592b..8f46d37c2b499 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -907,6 +907,7 @@
>  
>  #define USB_VENDOR_ID_MCS		0x16d0
>  #define USB_DEVICE_ID_MCS_GAMEPADBLOCK	0x0bcc
> +#define USB_DEVICE_ID_MCS_HEXDEV_HEXLIN	0x0648
>  
>  #define USB_VENDOR_MEGAWORLD		0x07b5
>  #define USB_DEVICE_ID_MEGAWORLD_GAMEPAD	0x0312
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 1d1949d62dfaf..a514449c50047 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -438,6 +438,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
>  #endif
> +#if IS_ENABLED(CONFIG_HID_MCS_HEXDEV)
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_HEXDEV_HEXLIN) },
> +#endif
>  #if IS_ENABLED(CONFIG_HID_HOLTEK)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD) },
> 

