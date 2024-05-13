Return-Path: <linux-can+bounces-636-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2128C40BA
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E96DB2329C
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFEB14F9C4;
	Mon, 13 May 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tyx1nlK9"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2914F103;
	Mon, 13 May 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603292; cv=none; b=BRop9kfYfQSOLAxXiiAclR4SSy6hlUh6skvQ/ud4y7xXKkUTwpAeDqIVEmoLCN60/3GN3MpAVcVMEJ5T5xJE7iGPX6VizsA5wucD2w24ScC9+uHCTFlGkVhxXvc9ETKI5pk8qWwc3CCJPmnYmLGGzVSn2PReqNBwdgnXHAIhxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603292; c=relaxed/simple;
	bh=pelZmS6zFQdTzAjl9pAUlFxDeQyc9gffvbQ7dqOMy98=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IjRHh7YL6Nn2ZFnw/iadrdB5MM83T1yXoBV/tLCr4WgR1GDO2oTIU0breNH0CEnZr6skOAXm7Nto16X37WiX1qjQyg/6VYCDYXU8kUaZGWIuef2NJnhshL8dkD5uT1NGvTHW9Z5lGf6zcLtvh9bcLicrFOX1PxKpvHKpxbRdZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tyx1nlK9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715603291; x=1747139291;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pelZmS6zFQdTzAjl9pAUlFxDeQyc9gffvbQ7dqOMy98=;
  b=Tyx1nlK9zeOZgbITWcWyGbwcVdBARt1IP9u2TDgz5774s1i1GMLWZTed
   TwznyHjPk7eYoGGNNH9aVHReaEvtdhdCo43/Us7+p0xwylNmJOmAifvxA
   sZHucWfM3/UIq+7TmTUmc5R3W/79BysDfg3CJS1/VViJMcArTn4z91NJC
   O7XZc040c/4TMgr8MqSJR1JIg/mkENPPeEJJaDJW1r/dhGMS1fSEUHD4G
   zPiLpFt40Eab5qP4nk9vBiMun59wm/GFJP/PTUjR1MdWPn0saCj/hg+Ga
   MbP8hSc001tuQbNv8Pw4MKhNKT2MKYLSbH5TMGkTN7BOfqoVGz+lKWyKW
   A==;
X-CSE-ConnectionGUID: d2ruA6gpRVSDgtQnrjPYFQ==
X-CSE-MsgGUID: 9Er9zJ2sRW+K9pcq/yb/nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22682054"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22682054"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 05:28:10 -0700
X-CSE-ConnectionGUID: WF3DJ0yaRmykx5Jte4aWwg==
X-CSE-MsgGUID: Ln+RwkV9RU2JRw/D6ynj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30437389"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 05:28:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 May 2024 15:27:56 +0300 (EEST)
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
In-Reply-To: <8738628a5c1b87c6521fdd8d05a3b36e5c32b48a.camel@hexdev.de>
Message-ID: <d91451f2-5636-2526-391d-f575a7feb17c@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>  <20240509171736.2048414-3-christoph.fritz@hexdev.de>  <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com> <8738628a5c1b87c6521fdd8d05a3b36e5c32b48a.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 May 2024, Christoph Fritz wrote:

> ...
> > > diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
> > > new file mode 100644
> > > index 0000000000000..a9ed080b3e33e
> > > --- /dev/null
> > > +++ b/drivers/hid/hid-hexdev-hexlin.c
> > > 
> ...
> > 
> > > +}
> > > +
> > > +#define HEXLIN_GET_CMD(name, enum_cmd)					\
> > > +	static int hexlin_##name(struct hexlin_priv_data *p)		\
> > > +	{								\
> > > +		u8 *req;						\
> > > +		int ret;						\
> > > +									\
> > > +		req = kmalloc(sizeof(*req), GFP_KERNEL)	;		\
> > 
> > Extra space.
> > 
> > Use:
> > 
> > u8 *req __free(kfree) = kmalloc(sizeof(*req), GFP_KERNEL);
> > 
> > > +		if (!req)						\
> > > +			return -ENOMEM;					\
> > > +									\
> > > +		*req = enum_cmd;					\
> > > +									\
> > > +		ret = hexlin_tx_req_status(p, req, sizeof(*req));	\
> > > +		if (ret)						\
> > > +			hid_err(p->hid_dev, "%s failed, error: %d\n",	\
> > > +				#name, ret);				\
> > > +									\
> > > +		kfree(req);						\
> > 
> > Not needed after using __free().
> > 
> > > +		return ret;						\
> > > +	}
> > > +
> > > +HEXLIN_GET_CMD(get_version, HEXLIN_GET_VERSION)
> > > +HEXLIN_GET_CMD(reset_dev, HEXLIN_RESET)
> > > +HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
> > 
> > Could you convert the function in the macro into a helper function which 
> > is just called by a simple function with the relevant parameters for 
> > these 3 cases?
> 
> The device actually has a lot more features that I'm using in my debug
> version and which might end up here in the future. So I would like to
> keep it. Any objections?

I don't follow, HEXLIN_GET_CMD() will always produce a copy of that same 
function even if you use it 1000 times?? (Except for the enum and string 
which can easily be passed as arguments to a common function).

You can still keep HEXLIN_GET_CMD() which just calls that common function
if you want to avoid giving those two parameters directly.

> > > +static int hexlin_set_baudrate(struct hexlin_priv_data *priv, u16 baudrate)
> > > +{
> > > +	struct hexlin_baudrate_req *req;
> > > +	int ret;
> > > +
> > > +	if (baudrate < LIN_MIN_BAUDRATE || baudrate > LIN_MAX_BAUDRATE)
> > > +		return -EINVAL;
> > > +
> > > +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> > 
> > Hmm... Why do you alloc this small structure (3 bytes?) with kmalloc() and 
> > not just have it in stack as a local variable?
> 
> This buffer must be suitable for DMA (see docu for struct urb).
> 
> So with a stack variable we would need to use kmemdup() before the
> actual sending call, but that's what you did not like since v3 so I
> changed it to this which now you also don't like.
>
> Let's dial it back to the original kmemdup() usage, ok?

I asked a question. Since you have a good reason for alloc, just keep the 
alloc then.

Now I notice it's kmalloc(), why not kzalloc()?

> > > +static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
> > > +				      const struct hexlin_frame *hxf)
> > > +{
> > > +	struct hid_device *hdev = priv->hid_dev;
> > > +	struct lin_frame lf;
> > > +
> > > +	lf.len = hxf->len;
> > > +	lf.lin_id = hxf->lin_id;
> > > +	memcpy(lf.data, hxf->data, LIN_MAX_DLEN);
> > > +	lf.checksum = hxf->checksum;
> > > +	lf.checksum_mode = hxf->checksum_mode;
> > > +
> > > +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, chk:%02x (%s), flg:%08x\n",
> > > +		lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> > > +		lf.checksum_mode ? "enhanced" : "classic", hxf->flags);
> > > +
> > > +	lin_rx(priv->ldev, &lf);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int hexlin_raw_event(struct hid_device *hdev,
> > > +			    struct hid_report *report, u8 *data, int sz)
> > > +{
> > > +	struct hexlin_priv_data *priv;
> > > +	struct hexlin_baudrate_req *br;
> > > +	struct hexlin_responder_answer_req *rar;
> > > +	struct hexlin_unconditional_req *hfr;
> > > +	struct hexlin_val8_req *vr;
> > > +
> > > +	if (sz < 1 || sz > HEXLIN_PKGLEN_MAX)
> > > +		return -EREMOTEIO;
> > > +
> > > +	priv = hid_get_drvdata(hdev);
> > > +
> > > +	hid_dbg(hdev, "%s, size:%i, data[0]: 0x%02x\n", __func__, sz, data[0]);
> > > +
> > > +	priv->is_error = false;
> > > +
> > > +	switch (data[0]) {
> > > +	case HEXLIN_SUCCESS:
> > > +		if (sz != HEXLIN_LEN_RETCODE)
> > > +			return -EREMOTEIO;
> > > +		hid_dbg(hdev, "HEXLIN_SUCCESS: 0x%02x\n", data[0]);
> > > +		complete(&priv->wait_in_report);
> > > +		break;
> > > +	case HEXLIN_FAIL:
> > > +		if (sz != HEXLIN_LEN_RETCODE)
> > > +			return -EREMOTEIO;
> > > +		hid_err(hdev, "HEXLIN_FAIL: 0x%02x\n", data[0]);
> > > +		priv->is_error = true;
> > > +		complete(&priv->wait_in_report);
> > > +		break;
> > > +	case HEXLIN_GET_VERSION:
> > > +		if (sz != sizeof(*vr))
> > > +			return -EREMOTEIO;
> > > +		vr = (struct hexlin_val8_req *) data;
> > > +		priv->fw_version = vr->v;
> > > +		complete(&priv->wait_in_report);
> > > +		break;
> > > +	case HEXLIN_GET_RESPONDER_ANSWER_ID:
> > > +		if (sz != sizeof(*rar))
> > > +			return -EREMOTEIO;
> > > +		rar = (struct hexlin_responder_answer_req *) data;
> > > +		memcpy(&priv->answ, &rar->answ, sizeof(priv->answ));
> > > +		complete(&priv->wait_in_report);
> > > +		break;
> > > +	case HEXLIN_GET_BAUDRATE:
> > > +		if (sz != sizeof(*br))
> > > +			return -EREMOTEIO;
> > > +		br = (struct hexlin_baudrate_req *) data;
> > > +		le16_to_cpus(br->baudrate);
> > > +		priv->baudrate = br->baudrate;
> > > +		complete(&priv->wait_in_report);
> > > +		break;
> > > +	/* following cases not initiated by us, so no complete() */
> > > +	case HEXLIN_FRAME:
> > > +		if (sz != sizeof(*hfr)) {
> > > +			hid_err_once(hdev, "frame size mismatch: %i\n", sz);
> > > +			return -EREMOTEIO;
> > > +		}
> > > +		hfr = (struct hexlin_unconditional_req *) data;
> > > +		le32_to_cpus(hfr->frm.flags);
> > 
> > I'm bit worried about this from endianness perspective. Perhaps there's 
> > some struct reusing that shouldn't be happening because the same field 
> > cannot be __le32 and u32 at the same time.
> 
> Can you propose a solution?

Just do a le32_to_cpu(hfr->frm.flags) in the debug print's arguments?

-- 
 i.


