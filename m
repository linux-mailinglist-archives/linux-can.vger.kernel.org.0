Return-Path: <linux-can+bounces-630-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A58D8C3032
	for <lists+linux-can@lfdr.de>; Sat, 11 May 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D711C211B1
	for <lists+linux-can@lfdr.de>; Sat, 11 May 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B27210EE;
	Sat, 11 May 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="qrzd/Q6C"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F233CF65;
	Sat, 11 May 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715415330; cv=none; b=nWCHj8s+Y+a/kf7nNv+dOVxCPdk86bhLNkUgvfkS0bL3cFTkILUr0HlE1Z4w7WNs6cheTD3d7jOssY+VOJ6ba6Q8rpUJeO8wkvg0GBZhLQ2iTRvz5ktCNgAWLcV4+24Cx1Gm9HGFZbctrbPyrx/k9jI0rULtuPngIR6Z+WhJw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715415330; c=relaxed/simple;
	bh=jUCqp7mbe1MgeyRsxbECoRThdo43Iu1WuFBlIsZaXMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLjE89dgSHeO3uaC/LxNxvJs+tqwO/89LF23OEvzfrrR0yIgDQqTX6O2y9ea1QmyHZoT6c4sxoYserkpkkfOgmD/ktUJDRD5VcXPJ3i+AwQnZXhLSezVf3LM21PyYJjmvxIJTweBzC/XAR6GbSUlXU3Sk890jctLNcoVFAGqjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=qrzd/Q6C; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JcD1RWz5//JWV1w0Jl43QQMXM9Jjam+DZ+mIDPZQTFw=; b=qrzd/Q6C+yjvVfmaP8CM53oHBP
	yt1nUxTRAPrNE6qINHezlr0FAZWe/fEGCkhHp3m+chFZIIeuuwnK46rt23xOdkzhcE/EVnpBfzCqv
	sMTQioQcQm3iEGsOL+r1coQ6zh7oMq8YOe8tdTFX/ZMM2DrFJjOis/k0ZpzSoNh3XvoU=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s5hsY-001mUp-12;
	Sat, 11 May 2024 10:14:51 +0200
Message-ID: <8738628a5c1b87c6521fdd8d05a3b36e5c32b48a.camel@hexdev.de>
Subject: Re: [PATCH v4 02/11] HID: hexLIN: Add support for USB LIN adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>,  "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Jonathan Corbet <corbet@lwn.net>, Pavel
 Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>,  devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
Date: Sat, 11 May 2024 10:14:46 +0200
In-Reply-To: <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
	 <20240509171736.2048414-3-christoph.fritz@hexdev.de>
	 <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com>
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
> > diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
> > new file mode 100644
> > index 0000000000000..a9ed080b3e33e
> > --- /dev/null
> > +++ b/drivers/hid/hid-hexdev-hexlin.c
> > 
...
> 
> > +}
> > +
> > +#define HEXLIN_GET_CMD(name, enum_cmd)					\
> > +	static int hexlin_##name(struct hexlin_priv_data *p)		\
> > +	{								\
> > +		u8 *req;						\
> > +		int ret;						\
> > +									\
> > +		req = kmalloc(sizeof(*req), GFP_KERNEL)	;		\
> 
> Extra space.
> 
> Use:
> 
> u8 *req __free(kfree) = kmalloc(sizeof(*req), GFP_KERNEL);
> 
> > +		if (!req)						\
> > +			return -ENOMEM;					\
> > +									\
> > +		*req = enum_cmd;					\
> > +									\
> > +		ret = hexlin_tx_req_status(p, req, sizeof(*req));	\
> > +		if (ret)						\
> > +			hid_err(p->hid_dev, "%s failed, error: %d\n",	\
> > +				#name, ret);				\
> > +									\
> > +		kfree(req);						\
> 
> Not needed after using __free().
> 
> > +		return ret;						\
> > +	}
> > +
> > +HEXLIN_GET_CMD(get_version, HEXLIN_GET_VERSION)
> > +HEXLIN_GET_CMD(reset_dev, HEXLIN_RESET)
> > +HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
> 
> Could you convert the function in the macro into a helper function which 
> is just called by a simple function with the relevant parameters for 
> these 3 cases?

The device actually has a lot more features that I'm using in my debug
version and which might end up here in the future. So I would like to
keep it. Any objections?

...
> > +
> > +static int hexlin_set_baudrate(struct hexlin_priv_data *priv, u16 baudrate)
> > +{
> > +	struct hexlin_baudrate_req *req;
> > +	int ret;
> > +
> > +	if (baudrate < LIN_MIN_BAUDRATE || baudrate > LIN_MAX_BAUDRATE)
> > +		return -EINVAL;
> > +
> > +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> 
> Hmm... Why do you alloc this small structure (3 bytes?) with kmalloc() and 
> not just have it in stack as a local variable?


This buffer must be suitable for DMA (see docu for struct urb).

So with a stack variable we would need to use kmemdup() before the
actual sending call, but that's what you did not like since v3 so I
changed it to this which now you also don't like.

Let's dial it back to the original kmemdup() usage, ok?

...
> > +static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
> > +				      const struct hexlin_frame *hxf)
> > +{
> > +	struct hid_device *hdev = priv->hid_dev;
> > +	struct lin_frame lf;
> > +
> > +	lf.len = hxf->len;
> > +	lf.lin_id = hxf->lin_id;
> > +	memcpy(lf.data, hxf->data, LIN_MAX_DLEN);
> > +	lf.checksum = hxf->checksum;
> > +	lf.checksum_mode = hxf->checksum_mode;
> > +
> > +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, chk:%02x (%s), flg:%08x\n",
> > +		lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> > +		lf.checksum_mode ? "enhanced" : "classic", hxf->flags);
> > +
> > +	lin_rx(priv->ldev, &lf);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hexlin_raw_event(struct hid_device *hdev,
> > +			    struct hid_report *report, u8 *data, int sz)
> > +{
> > +	struct hexlin_priv_data *priv;
> > +	struct hexlin_baudrate_req *br;
> > +	struct hexlin_responder_answer_req *rar;
> > +	struct hexlin_unconditional_req *hfr;
> > +	struct hexlin_val8_req *vr;
> > +
> > +	if (sz < 1 || sz > HEXLIN_PKGLEN_MAX)
> > +		return -EREMOTEIO;
> > +
> > +	priv = hid_get_drvdata(hdev);
> > +
> > +	hid_dbg(hdev, "%s, size:%i, data[0]: 0x%02x\n", __func__, sz, data[0]);
> > +
> > +	priv->is_error = false;
> > +
> > +	switch (data[0]) {
> > +	case HEXLIN_SUCCESS:
> > +		if (sz != HEXLIN_LEN_RETCODE)
> > +			return -EREMOTEIO;
> > +		hid_dbg(hdev, "HEXLIN_SUCCESS: 0x%02x\n", data[0]);
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_FAIL:
> > +		if (sz != HEXLIN_LEN_RETCODE)
> > +			return -EREMOTEIO;
> > +		hid_err(hdev, "HEXLIN_FAIL: 0x%02x\n", data[0]);
> > +		priv->is_error = true;
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_VERSION:
> > +		if (sz != sizeof(*vr))
> > +			return -EREMOTEIO;
> > +		vr = (struct hexlin_val8_req *) data;
> > +		priv->fw_version = vr->v;
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_RESPONDER_ANSWER_ID:
> > +		if (sz != sizeof(*rar))
> > +			return -EREMOTEIO;
> > +		rar = (struct hexlin_responder_answer_req *) data;
> > +		memcpy(&priv->answ, &rar->answ, sizeof(priv->answ));
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_BAUDRATE:
> > +		if (sz != sizeof(*br))
> > +			return -EREMOTEIO;
> > +		br = (struct hexlin_baudrate_req *) data;
> > +		le16_to_cpus(br->baudrate);
> > +		priv->baudrate = br->baudrate;
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	/* following cases not initiated by us, so no complete() */
> > +	case HEXLIN_FRAME:
> > +		if (sz != sizeof(*hfr)) {
> > +			hid_err_once(hdev, "frame size mismatch: %i\n", sz);
> > +			return -EREMOTEIO;
> > +		}
> > +		hfr = (struct hexlin_unconditional_req *) data;
> > +		le32_to_cpus(hfr->frm.flags);
> 
> I'm bit worried about this from endianness perspective. Perhaps there's 
> some struct reusing that shouldn't be happening because the same field 
> cannot be __le32 and u32 at the same time.

Can you propose a solution?

> 
...

thanks
  -- Christoph



