Return-Path: <linux-can+bounces-605-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8572E8C136F
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D451C20CC1
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F52DF44;
	Thu,  9 May 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="Fdij4UOf"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EBDDC1;
	Thu,  9 May 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274424; cv=none; b=qaoNvmrznySzEeteHaStQtCI4LLyQMLSeLuXgqBm+dJcWbmFh3HqPOSQm7xH7aQ1358DIV/LXJtPiWc71HHeHet/HAjLhSlGFQq8WkVVWFMih281lfBtEWRoTFxXpmlbJiuafNU8RwZVh4Ep8YR+s04D6H7jwmW/RxUr0TkFwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274424; c=relaxed/simple;
	bh=p+LZs47GSZnBzBhn7+RDHM6zFCQiPh3m9ivn0LTX8Jw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SSgHeKtHr9+prZC5PzAYW20ff3Ay4NADvSgfoGKC9ZA7ORrKLpwzXp2jJn0CLzAPRVowlouCtPB3Io1JYaSwXvp1YCfQsv4dwMrTPqbHVZhvqNXTTrQcSc8LOaSMkAuQ8vneAyAoC3hrf9pD6E/gVFmGTj4FI7DtVMBhlZ4YOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=Fdij4UOf; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UM164lg57y8gSxBIX5OTrFdatI1fhhq6+yWmZt0KJKo=; b=Fdij4UOfUNJgW8C1r2BFoAg3qG
	kfW1zw/9o6imQwsOriOsTU5Ac6gUiQonBA9SzYzs+r5pUFGuXursDuyuoLqV3dyHbULssg8ov+qDM
	81eosiAL9GgMeJAz1LGMCnNCoPp45PuYduo6iiadiGsww/c3YHwzjyPnGrM2jx0sAPv4=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57E5-001jbO-0L;
	Thu, 09 May 2024 19:06:37 +0200
Message-ID: <02d9e48619cff27fb846b5d8f367bc033bbf91e6.camel@hexdev.de>
Subject: Re: [PATCH v3 02/11] HID: hexLIN: Add support for USB LIN bus
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>,  Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,  Netdev
 <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial <linux-serial@vger.kernel.org>
Date: Thu, 09 May 2024 19:06:35 +0200
In-Reply-To: <422e0d3a-3eb9-ff78-8419-56e894e04137@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-3-christoph.fritz@hexdev.de>
	 <422e0d3a-3eb9-ff78-8419-56e894e04137@linux.intel.com>
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

On Mon, 2024-05-06 at 19:53 +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Christoph Fritz wrote:
> 
> > This patch introduces driver support for the hexLIN USB LIN bus adapter,
> > enabling LIN communication over USB for both controller and responder
> > modes. The driver interfaces with the CAN_LIN framework for userland
> > connectivity.
> > 
> > For more details on the adapter, visit: https://hexdev.de/hexlin/
> > 
> > Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  drivers/hid/Kconfig             |  19 +
> >  drivers/hid/Makefile            |   1 +
> >  drivers/hid/hid-hexdev-hexlin.c | 611 ++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-ids.h           |   1 +
> >  drivers/hid/hid-quirks.c        |   3 +
> >  5 files changed, 635 insertions(+)
> >  create mode 100644 drivers/hid/hid-hexdev-hexlin.c
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 4c682c6507040..d2fb35d83c640 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -496,6 +496,25 @@ config HID_GYRATION
> >  	help
> >  	Support for Gyration remote control.
> >  
> > +config HID_MCS_HEXDEV
> > +	tristate "hexDEV LIN-BUS adapter support"
> > +	depends on HID && CAN_NETLINK && CAN_DEV
> > +	select CAN_LIN
> > +	help
> > +	  Support for hexDEV its hexLIN USB LIN bus adapter.
> > +
> > +	  Local Interconnect Network (LIN) to USB adapter for controller and
> > +	  responder usage.
> > +	  This device driver is using CAN_LIN for a userland connection on
> > +	  one side and USB HID for the actual hardware adapter on the other
> > +	  side.
> > +
> > +	  If you have such an adapter, say Y here and see
> > +	  <https://hexdev.de/hexlin>.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-hexlin.
> > +
> >  config HID_ICADE
> >  	tristate "ION iCade arcade controller"
> >  	help
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 082a728eac600..f9b13e6117e60 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -59,6 +59,7 @@ obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
> >  obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
> >  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
> >  obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
> > +obj-$(CONFIG_HID_MCS_HEXDEV)	+= hid-hexdev-hexlin.o
> >  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
> >  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
> >  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
> > diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
> > new file mode 100644
> > index 0000000000000..1ddc1e00ab2da
> > --- /dev/null
> > +++ b/drivers/hid/hid-hexdev-hexlin.c
> > @@ -0,0 +1,611 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * LIN bus USB adapter driver https://hexdev.de/hexlin
> > + *
> > + * Copyright (C) 2024 hexDEV GmbH
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +#include <linux/wait.h>
> > +#include <net/lin.h>
> > +#include "hid-ids.h"
> > +
> > +enum {
> > +	/* answers */
> > +	HEXLIN_SUCCESS = 0x01,
> > +	HEXLIN_FRAME = 0x02,
> > +	HEXLIN_ERROR = 0x03,
> > +	HEXLIN_FAIL = 0x0F,
> > +
> > +	/* lin-responder */
> > +	HEXLIN_SET_MODE_RESPONDER = 0x10,
> > +	HEXLIN_SET_RESPONDER_ANSWER_ID = 0x11,
> > +	HEXLIN_GET_RESPONDER_ANSWER_ID = 0x12,
> > +
> > +	/* lin-controller */
> > +	HEXLIN_SET_MODE_CONTROLLER = 0x20,
> > +	HEXLIN_SEND_BREAK = 0x21,
> > +	HEXLIN_SEND_UNCONDITIONAL_FRAME = 0x22,
> > +
> > +	/* lin-div */
> > +	HEXLIN_SET_BAUDRATE = 0x34,
> > +	HEXLIN_GET_BAUDRATE = 0x35,
> > +
> > +	/* div */
> > +	HEXLIN_RESET = 0xF0,
> > +	HEXLIN_GET_VERSION = 0xF1,
> 
> Could you align the values?

OK

> 
> > +};
> > +
> > +#define HEXLIN_SUCCESS_SZ			1
> > +#define HEXLIN_FRAME_SZ				17
> > +#define HEXLIN_FAIL_SZ				1
> > +#define HEXLIN_GET_RESPONDER_ANSWER_ID_SZ	20
> > +#define HEXLIN_GET_BAUDRATE_SZ			3
> 
> Is this sizeof(hexlin_baudrate_req)?

No

> If so, don't add define for it.
> This probably applies to other defines here too.

I'll refactor these defines in upcoming v4 to a minimum.

> 
> > +#define HEXLIN_BAUDRATE_SZ			2
> > +#define HEXLIN_GET_VERSION_SZ			2
> > +#define HEXLIN_PKGLEN_MAX_SZ			64
> > +
> > +struct hexlin_val8_req {
> > +	u8 cmd;
> > +	u8 v;
> > +} __packed;
> > +
> > +struct hexlin_baudrate_req {
> > +	u8 cmd;
> > +	u16 baudrate;
> > +} __packed;
> > +
> > +struct hexlin_frame {
> > +	u32 flags;
> > +	u8 len;
> > +	u8 lin_id;
> > +	u8 data[LIN_MAX_DLEN];
> > +	u8 checksum;
> > +	u8 checksum_mode;
> > +} __packed;
> > +
> > +struct hexlin_unconditional_req {
> > +	u8 cmd;
> > +	struct hexlin_frame frm;
> > +} __packed;
> > +
> > +struct hexlin_responder_answer {
> > +	u8 is_active;
> > +	u8 is_event_frame;
> > +	u8 event_associated_id;
> > +	struct hexlin_frame frm;
> > +} __packed;
> > +
> > +struct hexlin_responder_answer_req {
> > +	u8 cmd;
> > +	struct hexlin_responder_answer answ;
> > +} __packed;
> > +
> > +struct hexlin_priv_data {
> > +	struct hid_device *hid_dev;
> > +	struct lin_device *ldev;
> > +	u16 baudrate;
> > +	struct completion wait_in_report;
> > +	bool is_error;
> > +	struct mutex tx_lock;  /* protects hexlin_tx_report() */
> > +	struct hexlin_responder_answer_req rar;
> > +	u8 fw_version;
> > +};
> > +
> > +static int hexlin_tx_report(struct hexlin_priv_data *priv,
> > +			    const void *out_report, size_t len)
> > +{
> > +	u8 *buf;
> > +	int ret;
> > +
> > +	buf = kmemdup(out_report, len, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	ret = hid_hw_output_report(priv->hid_dev, buf, len);
> > +	kfree(buf);
> 
> Is duplicatign the buffer necessary?

No, my intention was to keep the functions calling hexlin_tx_report()
simpler and let the compiler optimize this.

In the upcoming v4, I merged this into hexlin_tx_req_status() and
dropped the kmemdup().

> 
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != len)
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int hexlin_tx_req_status(struct hexlin_priv_data *priv,
> > +				const void *out_report, int len)
> > +{
> > +	int ret;
> > +	unsigned long t;
> > +
> > +	mutex_lock(&priv->tx_lock);
> > +
> > +	reinit_completion(&priv->wait_in_report);
> > +
> > +	ret = hexlin_tx_report(priv, out_report, len);
> > +	if (ret)
> > +		goto tx_exit;
> > +
> > +	t = wait_for_completion_killable_timeout(&priv->wait_in_report,
> > +						 msecs_to_jiffies(1000));
> 
> HZ?

OK

> 
> > +	if (!t)
> > +		ret = -ETIMEDOUT;
> > +
> > +	if (priv->is_error)
> > +		ret = -EINVAL;
> > +
> > +tx_exit:
> > +	mutex_unlock(&priv->tx_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +#define HEXLIN_GET_CMD(name, enum_cmd)					\
> > +	static int hexlin_##name(struct hexlin_priv_data *priv)		\
> > +	{								\
> > +		u8 cmd = enum_cmd;					\
> > +		int ret;						\
> > +									\
> > +		ret = hexlin_tx_req_status(priv, &cmd, sizeof(u8));	\
> 
> Take sizeof() of the relevant variable instead, so:
> 
> sizeof(cmd)

OK

> 
> > +		if (ret)						\
> > +			hid_err(priv->hid_dev, "%s failed with %d\n",	\
> > +				__func__, ret);				\
> > +									\
> > +		return ret;						\
> > +	}
> > +
> > +HEXLIN_GET_CMD(get_version, HEXLIN_GET_VERSION)
> > +HEXLIN_GET_CMD(reset_dev, HEXLIN_RESET)
> > +HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
> > +
> > +#define HEXLIN_VAL_CMD(name, enum_cmd, struct_type, vtype)		\
> > +	static int hexlin_##name(struct hexlin_priv_data *p, vtype val)	\
> > +	{								\
> > +		struct struct_type req;					\
> > +		int ret;						\
> > +									\
> > +		req.cmd = enum_cmd;					\
> > +		req.v = val;						\
> > +									\
> > +		ret = hexlin_tx_req_status(p, &req,			\
> > +					   sizeof(struct struct_type));	\
> 
> sizeof(req)

OK

> 
> > +		if (ret)						\
> > +			hid_err(p->hid_dev, "%s failed with %d\n",	\
> > +				__func__, ret);				\
> > +									\
> > +		return ret;						\
> > +	}
> > +
> > +HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
> > +
> > +static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
> > +				      const u8 *raw_data, int sz)
> > +{
> > +	struct hid_device *hdev = priv->hid_dev;
> > +	struct hexlin_frame hxf;
> > +	struct lin_frame lf;
> > +
> > +	if (sz != sizeof(struct hexlin_frame))
> > +		return -EREMOTEIO;
> > +
> > +	memcpy(&hxf, raw_data, sz);
> 
> Why you cannot just cast the pointer to correct type?

I can, will be refactored in v4.

> 
> > +	le32_to_cpus(hxf.flags);
> 
> You must use correct endianess typing. The struct hexlin_frame should have 
> __le32 flags so sparse's endianness check is happy.

OK

> 
> But .flags are not used at all so why is this required in the first place?

Was necessary in the development process and will be used in hid_dbg()
below in v4.

> 
> > +	lf.len = hxf.len;
> > +	lf.lin_id = hxf.lin_id;
> > +	memcpy(lf.data, hxf.data, LIN_MAX_DLEN);
> > +	lf.checksum = hxf.checksum;
> > +	lf.checksum_mode = hxf.checksum_mode;
> > +
> > +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> > +		   lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> > +		   lf.checksum_mode ? "enhanced" : "classic");
> > +
> > +	lin_rx(priv->ldev, &lf);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hexlin_send_unconditional(struct hexlin_priv_data *priv,
> > +			      const struct hexlin_frame *hxf)
> > +{
> > +	struct hexlin_unconditional_req req;
> > +	int ret;
> > +
> > +	if (hxf->lin_id > LIN_ID_MASK)
> > +		return -EINVAL;
> > +
> > +	req.cmd = HEXLIN_SEND_UNCONDITIONAL_FRAME;
> > +	memcpy(&req.frm, hxf, sizeof(struct hexlin_frame));
> > +
> > +	ret = hexlin_tx_req_status(priv, &req,
> > +				   sizeof(struct hexlin_unconditional_req));
> 
> sizeof(req)

OK

> 
> > +
> > +	if (ret)
> > +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int hexlin_set_baudrate(struct hexlin_priv_data *priv, u16 baudrate)
> > +{
> > +	struct hexlin_baudrate_req req;
> > +	int ret;
> > +
> > +	if (baudrate < LIN_MIN_BAUDRATE || baudrate > LIN_MAX_BAUDRATE)
> > +		return -EINVAL;
> > +
> > +	req.cmd = HEXLIN_SET_BAUDRATE;
> > +	req.baudrate = cpu_to_le16(baudrate);
> 
> The struct should have __le16 baudrate.

OK

> 
> > +
> > +	ret = hexlin_tx_req_status(priv, &req,
> > +				   sizeof(struct hexlin_baudrate_req));
> > +	if (ret)
> > +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int hexlin_get_responder_answer_id(struct hexlin_priv_data *priv, u8 id,
> > +					  struct hexlin_responder_answer_req *rar)
> > +{
> > +	u8 req[2] = { HEXLIN_GET_RESPONDER_ANSWER_ID, id };
> > +	int ret;
> > +
> > +	if (id > LIN_ID_MASK)
> > +		return -EINVAL;
> > +
> > +	ret = hexlin_tx_req_status(priv, &req, sizeof(req));
> > +	if (ret) {
> > +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> 
> Try to write error message that is meaningful to user, printing __func__ 
> is not very helpful for user.

OK, will be refactored in v4.

> 
> > +		return ret;
> > +	}
> > +
> > +	memcpy(rar, &priv->rar, sizeof(struct hexlin_responder_answer_req));
> 
> sizeof(*rar)

OK

> 
> > +	return 0;
> > +}
> > +
> > +static int hexlin_set_responder_answer_id(struct hexlin_priv_data *priv,
> > +					  const struct lin_responder_answer *answ)
> > +{
> > +	struct hexlin_responder_answer_req rar;
> > +	int ret;
> > +
> > +	if (answ->lf.lin_id > LIN_ID_MASK ||
> > +	    answ->event_associated_id > LIN_ID_MASK)
> > +		return -EINVAL;
> > +
> > +	rar.cmd = HEXLIN_SET_RESPONDER_ANSWER_ID;
> > +	rar.answ.is_active = answ->is_active;
> > +	rar.answ.is_event_frame = answ->is_event_frame;
> > +	rar.answ.event_associated_id = answ->event_associated_id;
> > +	rar.answ.frm.len = answ->lf.len;
> > +	rar.answ.frm.lin_id = answ->lf.lin_id;
> > +	memcpy(rar.answ.frm.data, answ->lf.data, LIN_MAX_DLEN);
> > +	rar.answ.frm.checksum = answ->lf.checksum;
> > +	rar.answ.frm.checksum_mode = answ->lf.checksum_mode;
> > +
> > +	ret = hexlin_tx_req_status(priv, &rar,
> > +				   sizeof(struct hexlin_responder_answer_req));
> 
> Ditto.

OK

thanks
  -- Christoph



