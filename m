Return-Path: <linux-can+bounces-624-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EA8C2600
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79443B21553
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBF12C498;
	Fri, 10 May 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgJ+Fvsf"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3812C47D;
	Fri, 10 May 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348821; cv=none; b=UgqLP9JCQGZKIrcAISOYSJY6coMWw6Pkumk61iO0FkuUQ+Fk9PYAy6jCjg9fJxVGBpbYEgtoxx8kqC7htNsba+cvz/15otV/OImgWwrwUqDvKYdR6EYXhV4Jr7YCUR/JOKSWLGLLg5IclDZLn0UZyUJpNyGN/YeumG+ZfmbLBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348821; c=relaxed/simple;
	bh=kzq6xPktmwyI6cLzBt7/inx8gIMb7qmXJ8/lA7TcBBw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lI5mouwWPrXSiVdH6FWUFc6gDiiLVRuzWAjZs96B6maJR/3peemxcY1l9wDNZjc8GeaZRstKlJu9kBcNZsKm4mmnIF1h8tnLIcuNbWl+t8VoWlirR1LWAANfmxssrXw3GqGOTF1tlk1oMGaQzVlnaVEZ6JM+PEW6mbsqIvN1Dk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgJ+Fvsf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715348819; x=1746884819;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kzq6xPktmwyI6cLzBt7/inx8gIMb7qmXJ8/lA7TcBBw=;
  b=FgJ+FvsfT9/akkco6KopBq6hrAaoN+cECyOkqrNCLVLZDbWzEUkM3iSK
   QfOUJ+WGhHdWfkgE7T8PtlAtE8ZIhHjx3meDTF/ziLvBQj9E766NPkv6H
   GrQrid1NXGlpcjKpBHzftN4ayF6kFy+kOLZkj+kbYr3YzL5FKabUrpmUG
   4HYiwRUd6eN2e4reN0vhatjYLF4aGsWHGi3SPKnPsUdiXbOz6H0JVQS49
   xlcUGJt7omKm4OLhnp0F2jgpudwaifw3P+AYEhYiNcLiFXhC9MwryieEA
   32qHoHLln6+bUfjutxND5bx8ANwQ8rJW/36gvMP0fuxxj6SMI9ZA9+utb
   Q==;
X-CSE-ConnectionGUID: h20ejQKqSq6W0Q2pYG5vGQ==
X-CSE-MsgGUID: H1SZdVr9QgOc4g9v0czJRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11466736"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11466736"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:46:58 -0700
X-CSE-ConnectionGUID: G9dndEvyRk+TW5n2reYINQ==
X-CSE-MsgGUID: A5pMg1KXT6aHtSsvTUgLbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34158748"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:46:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 16:46:43 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] HID: hexLIN: Add support for USB LIN adapter
In-Reply-To: <20240509171736.2048414-3-christoph.fritz@hexdev.de>
Message-ID: <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-3-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Christoph Fritz wrote:

> Introduce driver support for hexDEV hexLIN USB LIN adapter, enabling LIN
> communication over USB for both controller and responder modes. The
> driver interfaces with the CAN_LIN framework for userland connectivity.
> 
> For more details on the adapter, visit: https://hexdev.de/hexlin/
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/hid/Kconfig             |  19 +
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-hexdev-hexlin.c | 609 ++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h           |   1 +
>  drivers/hid/hid-quirks.c        |   3 +
>  5 files changed, 633 insertions(+)
>  create mode 100644 drivers/hid/hid-hexdev-hexlin.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 08446c89eff6e..682e3ab5fdfe5 100644
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
> index ce71b53ea6c54..6af678f283548 100644
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
> index 0000000000000..a9ed080b3e33e
> --- /dev/null
> +++ b/drivers/hid/hid-hexdev-hexlin.c
> @@ -0,0 +1,609 @@
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
> +#define HEXLIN_PKGLEN_MAX	64
> +#define HEXLIN_LEN_RETCODE	1
> +
> +enum {
> +	/* answers */
> +	HEXLIN_SUCCESS			= 0x01,
> +	HEXLIN_FRAME			= 0x02,
> +	HEXLIN_ERROR			= 0x03,
> +	HEXLIN_FAIL			= 0x0F,
> +	/* lin-responder */
> +	HEXLIN_SET_MODE_RESPONDER	= 0x10,
> +	HEXLIN_SET_RESPONDER_ANSWER_ID	= 0x11,
> +	HEXLIN_GET_RESPONDER_ANSWER_ID	= 0x12,
> +	/* lin-controller */
> +	HEXLIN_SET_MODE_CONTROLLER	= 0x20,
> +	HEXLIN_SEND_BREAK		= 0x21,
> +	HEXLIN_SEND_UNCONDITIONAL_FRAME	= 0x22,
> +	/* lin-div */
> +	HEXLIN_SET_BAUDRATE		= 0x34,
> +	HEXLIN_GET_BAUDRATE		= 0x35,
> +	/* div */
> +	HEXLIN_RESET			= 0xF0,
> +	HEXLIN_GET_VERSION		= 0xF1,
> +};
> +
> +struct hexlin_val8_req {
> +	u8 cmd;
> +	u8 v;
> +} __packed;
> +
> +struct hexlin_baudrate_req {
> +	u8 cmd;
> +	__le16 baudrate;
> +} __packed;
> +
> +struct hexlin_frame {
> +	__le32 flags;
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
> +	struct hexlin_responder_answer answ;
> +	u8 fw_version;
> +};
> +
> +static int hexlin_tx_req_status(struct hexlin_priv_data *priv,
> +				const void *out_report, int len)
> +{
> +	unsigned long t;
> +	int n, ret = 0;
> +
> +	mutex_lock(&priv->tx_lock);

Use guard().

In general btw, if you're instructed to change something, it's useful to 
check your own patch series for similar cases as review pass is likely to 
miss some or not even spend time to point out the same thing over and 
over again. Then they are raised on the next review round which could have 
been avoided.

> +	reinit_completion(&priv->wait_in_report);
> +
> +	n = hid_hw_output_report(priv->hid_dev, (__u8 *) out_report, len);

The usual is to not leave space between cast and what is being cast. I 
know hid functions seem to use __u8 but that's intended for uapi and in 
kernel, u8 should be used (somebody should eventually cleanup the hid 
function types too).

> +	if (n < 0) {
> +		mutex_unlock(&priv->tx_lock);
> +		return n;
> +	}
> +	if (n != len) {
> +		mutex_unlock(&priv->tx_lock);
> +		return -EIO;
> +	}
> +
> +	t = wait_for_completion_killable_timeout(&priv->wait_in_report, HZ);
> +	if (!t)
> +		ret = -ETIMEDOUT;
> +
> +	if (priv->is_error)
> +		ret = -EINVAL;

These can return directly when you use guard().

> +	mutex_unlock(&priv->tx_lock);
> +
> +	return ret;

return 0; + drop ret variable.

> +}
> +
> +#define HEXLIN_GET_CMD(name, enum_cmd)					\
> +	static int hexlin_##name(struct hexlin_priv_data *p)		\
> +	{								\
> +		u8 *req;						\
> +		int ret;						\
> +									\
> +		req = kmalloc(sizeof(*req), GFP_KERNEL)	;		\

Extra space.

Use:

u8 *req __free(kfree) = kmalloc(sizeof(*req), GFP_KERNEL);

> +		if (!req)						\
> +			return -ENOMEM;					\
> +									\
> +		*req = enum_cmd;					\
> +									\
> +		ret = hexlin_tx_req_status(p, req, sizeof(*req));	\
> +		if (ret)						\
> +			hid_err(p->hid_dev, "%s failed, error: %d\n",	\
> +				#name, ret);				\
> +									\
> +		kfree(req);						\

Not needed after using __free().

> +		return ret;						\
> +	}
> +
> +HEXLIN_GET_CMD(get_version, HEXLIN_GET_VERSION)
> +HEXLIN_GET_CMD(reset_dev, HEXLIN_RESET)
> +HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)

Could you convert the function in the macro into a helper function which 
is just called by a simple function with the relevant parameters for 
these 3 cases?

> +#define HEXLIN_VAL_CMD(name, enum_cmd, struct_type, vtype)		\
> +	static int hexlin_##name(struct hexlin_priv_data *p, vtype val)	\
> +	{								\
> +		struct struct_type *req;				\
> +		int ret;						\
> +									\
> +		req = kmalloc(sizeof(*req), GFP_KERNEL)	;		\

Extra space.

Use __free().

> +		if (!req)						\
> +			return -ENOMEM;					\
> +									\
> +		req->cmd = enum_cmd;					\
> +		req->v = val;						\
> +									\
> +		ret = hexlin_tx_req_status(p, req, sizeof(*req));	\
> +		if (ret)						\
> +			hid_err(p->hid_dev, "%s failed, error: %d\n",	\
> +				#name, ret);				\
> +									\
> +		kfree(req);						\
> +		return ret;						\
> +	}
> +
> +HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
> +
> +static int hexlin_send_unconditional(struct hexlin_priv_data *priv,
> +				     const struct hexlin_frame *hxf)
> +{
> +	struct hexlin_unconditional_req *req;
> +	int ret;
> +
> +	if (hxf->lin_id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->cmd = HEXLIN_SEND_UNCONDITIONAL_FRAME;
> +	memcpy(&req->frm, hxf, sizeof(*hxf));
> +
> +	ret = hexlin_tx_req_status(priv, req, sizeof(*req));
> +	if (ret)
> +		hid_err(priv->hid_dev, "unconditional tx failed: %d\n", ret);
> +
> +	kfree(req);
> +	return ret;
> +}
> +
> +static int hexlin_set_baudrate(struct hexlin_priv_data *priv, u16 baudrate)
> +{
> +	struct hexlin_baudrate_req *req;
> +	int ret;
> +
> +	if (baudrate < LIN_MIN_BAUDRATE || baudrate > LIN_MAX_BAUDRATE)
> +		return -EINVAL;
> +
> +	req = kmalloc(sizeof(*req), GFP_KERNEL);

Hmm... Why do you alloc this small structure (3 bytes?) with kmalloc() and 
not just have it in stack as a local variable?

> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->cmd = HEXLIN_SET_BAUDRATE;
> +	req->baudrate = cpu_to_le16(baudrate);
> +
> +	ret = hexlin_tx_req_status(priv, req, sizeof(*req));
> +	if (ret)
> +		hid_err(priv->hid_dev, "set baudrate failed: %d\n", ret);
> +
> +	kfree(req);
> +	return ret;
> +}
> +
> +static int hexlin_get_responder_answer_id(struct hexlin_priv_data *priv, u8 id,
> +					  struct hexlin_responder_answer *ransw)
> +{
> +	struct hexlin_val8_req *req;
> +	int ret;
> +
> +	if (id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	req = kmalloc(sizeof(*req), GFP_KERNEL);

Use a stack variable instead?

> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->cmd = HEXLIN_GET_RESPONDER_ANSWER_ID;
> +	req->v = id;
> +
> +	ret = hexlin_tx_req_status(priv, req, sizeof(*req));
> +	if (ret) {
> +		hid_err(priv->hid_dev, "get respond answer failed: %d\n", ret);
> +		kfree(req);
> +		return ret;
> +	}
> +
> +	memcpy(ransw, &priv->answ, sizeof(priv->answ));
> +
> +	kfree(req);
> +	return 0;
> +}
> +
> +static int hexlin_set_responder_answer_id(struct hexlin_priv_data *priv,
> +					  const struct lin_responder_answer *answ)
> +{
> +	struct hexlin_responder_answer_req *req;
> +	int ret;
> +
> +	if (answ->lf.lin_id > LIN_ID_MASK ||
> +	    answ->event_associated_id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->cmd = HEXLIN_SET_RESPONDER_ANSWER_ID;
> +	req->answ.is_active = answ->is_active;
> +	req->answ.is_event_frame = answ->is_event_frame;
> +	req->answ.event_associated_id = answ->event_associated_id;
> +	req->answ.frm.len = answ->lf.len;
> +	req->answ.frm.lin_id = answ->lf.lin_id;
> +	memcpy(req->answ.frm.data, answ->lf.data, LIN_MAX_DLEN);
> +	req->answ.frm.checksum = answ->lf.checksum;
> +	req->answ.frm.checksum_mode = answ->lf.checksum_mode;
> +
> +	ret = hexlin_tx_req_status(priv, req, sizeof(*req));
> +	if (ret)
> +		hid_err(priv->hid_dev, "set respond answer failed: %d\n", ret);
> +
> +	kfree(req);
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
> +	struct hexlin_responder_answer ransw;
> +	int ret;
> +
> +	if (answ == NULL)
> +		return -EINVAL;
> +
> +	ret = hexlin_get_responder_answer_id(priv, id, &ransw);
> +	if (ret)
> +		return ret;
> +
> +	answ->is_active = ransw.is_active;
> +	answ->is_event_frame = ransw.is_event_frame;
> +	answ->event_associated_id = ransw.event_associated_id;
> +	answ->lf.len = ransw.frm.len;
> +	answ->lf.lin_id = ransw.frm.lin_id;
> +	memcpy(answ->lf.data, ransw.frm.data, LIN_MAX_DLEN);
> +	answ->lf.checksum = ransw.frm.checksum;
> +	answ->lf.checksum_mode = ransw.frm.checksum_mode;
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
> +static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
> +				      const struct hexlin_frame *hxf)
> +{
> +	struct hid_device *hdev = priv->hid_dev;
> +	struct lin_frame lf;
> +
> +	lf.len = hxf->len;
> +	lf.lin_id = hxf->lin_id;
> +	memcpy(lf.data, hxf->data, LIN_MAX_DLEN);
> +	lf.checksum = hxf->checksum;
> +	lf.checksum_mode = hxf->checksum_mode;
> +
> +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, chk:%02x (%s), flg:%08x\n",
> +		lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> +		lf.checksum_mode ? "enhanced" : "classic", hxf->flags);
> +
> +	lin_rx(priv->ldev, &lf);
> +
> +	return 0;
> +}
> +
> +static int hexlin_raw_event(struct hid_device *hdev,
> +			    struct hid_report *report, u8 *data, int sz)
> +{
> +	struct hexlin_priv_data *priv;
> +	struct hexlin_baudrate_req *br;
> +	struct hexlin_responder_answer_req *rar;
> +	struct hexlin_unconditional_req *hfr;
> +	struct hexlin_val8_req *vr;
> +
> +	if (sz < 1 || sz > HEXLIN_PKGLEN_MAX)
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
> +		if (sz != HEXLIN_LEN_RETCODE)
> +			return -EREMOTEIO;
> +		hid_dbg(hdev, "HEXLIN_SUCCESS: 0x%02x\n", data[0]);
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_FAIL:
> +		if (sz != HEXLIN_LEN_RETCODE)
> +			return -EREMOTEIO;
> +		hid_err(hdev, "HEXLIN_FAIL: 0x%02x\n", data[0]);
> +		priv->is_error = true;
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_VERSION:
> +		if (sz != sizeof(*vr))
> +			return -EREMOTEIO;
> +		vr = (struct hexlin_val8_req *) data;
> +		priv->fw_version = vr->v;
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_RESPONDER_ANSWER_ID:
> +		if (sz != sizeof(*rar))
> +			return -EREMOTEIO;
> +		rar = (struct hexlin_responder_answer_req *) data;
> +		memcpy(&priv->answ, &rar->answ, sizeof(priv->answ));
> +		complete(&priv->wait_in_report);
> +		break;
> +	case HEXLIN_GET_BAUDRATE:
> +		if (sz != sizeof(*br))
> +			return -EREMOTEIO;
> +		br = (struct hexlin_baudrate_req *) data;
> +		le16_to_cpus(br->baudrate);
> +		priv->baudrate = br->baudrate;
> +		complete(&priv->wait_in_report);
> +		break;
> +	/* following cases not initiated by us, so no complete() */
> +	case HEXLIN_FRAME:
> +		if (sz != sizeof(*hfr)) {
> +			hid_err_once(hdev, "frame size mismatch: %i\n", sz);
> +			return -EREMOTEIO;
> +		}
> +		hfr = (struct hexlin_unconditional_req *) data;
> +		le32_to_cpus(hfr->frm.flags);

I'm bit worried about this from endianness perspective. Perhaps there's 
some struct reusing that shouldn't be happening because the same field 
cannot be __le32 and u32 at the same time.

> +		hexlin_queue_frames_insert(priv, &hfr->frm);
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
> +	if (IS_ERR(priv->ldev)) {
> +		ret = PTR_ERR(priv->ldev);
> +		goto fail_and_close;
> +	}
> +
> +	hid_hw_close(hdev);
> +
> +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);

By custom, the success path in probe should not print anything so make 
this dbg level message if the fw version information is valuable in some 
debugging scenario.

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
> index 61d2a21affa26..c6fe6f99a0e80 100644
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
> index e0bbf0c6345d6..d721110d0889b 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -436,6 +436,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
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

-- 
 i.


