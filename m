Return-Path: <linux-can+bounces-593-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA78BF8D2
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056371F258F3
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8254902;
	Wed,  8 May 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="KmxqBOfK"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFF548E4;
	Wed,  8 May 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157482; cv=none; b=m78+hO7/bTlWP9NfVXKAhc1i1k54BAcH56ZvMqYWVv79wneH4uyoWMCX/rog4j2obu5cxshPftGEf3bq7OpA242QXO8J4i/YSVeZMYHGNK8n2kYcciW/JuDLprFlhHZbjDGadZ7GMWYjvAnbp1AW9D2uQc7YQ/dy4TAheIbvMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157482; c=relaxed/simple;
	bh=9AjlhM0sWYPu1nGwE34U3Kl+ycclxgyy2cXzdJFueqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLfeI1XGFnT9/kk7SXQbTDL2KFyZMOktkWwHQAAJqSxugGwWJzit6lqxNvzOwkoyaQbUpkDxfIRSXQv0VmvfAz/Mw4QCTpd9XeKFSAtsehDq2N08Du/rU8a5AHMZfvp28VD3DsW7oNBpU5yWZ6JXlr4ECmzWMFCE8Jdzog2jtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=KmxqBOfK; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d4IrycAw86Vg37ALA8F7zQoyYSzRTtsKV382FbyAFBU=; b=KmxqBOfK+v4xpEj7Sy3Uh2G83h
	+b9SOEYUVk1W7of8Iv0YB3lUrXsWgNiVgRS6KfxTB31klgMvtUR6hjHRRxvSJDDrHXe/JdA/fCm1B
	B+ddousDfC+bl6xrbztqNFjRnKE+3a04agFzLZ/rk400HttKS5t70TVjm8sujUkz9ZtU=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4co3-001hLv-29;
	Wed, 08 May 2024 10:37:44 +0200
Message-ID: <45ed69b00f64607c70f1090941f36b71202807f2.camel@hexdev.de>
Subject: Re: [PATCH v2 02/12] HID: hexLIN: Add support for USB LIN bus
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Simon Horman <horms@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Sebastian
 Reichel <sre@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>,
 Andreas Lauser <andreas.lauser@mercedes-benz.com>, Jonathan Corbet
 <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Wed, 08 May 2024 10:37:42 +0200
In-Reply-To: <20240504125828.GK3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-3-christoph.fritz@hexdev.de>
	 <20240504125828.GK3167983@kernel.org>
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

On Sat, 2024-05-04 at 13:58 +0100, Simon Horman wrote:
> On Thu, May 02, 2024 at 09:55:24AM +0200, Christoph Fritz wrote:
> > This patch introduces driver support for the hexLIN USB LIN bus adapter,
> > enabling LIN communication over USB for both controller and responder
> > modes. The driver interfaces with the CAN_LIN framework for userland
> > connectivity.
> > 
> > For more details on the adapter, visit: https://hexdev.de/hexlin/
> > 
> > Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> 
> Hi Christoph,
> 
> Some minor feedback from my side.
> 
> ...
> 
> > diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
> 
> ...
> 
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
> > +	le32_to_cpus(hxf.flags);
> > +
> > +	lf.len = hxf.len;
> > +	lf.lin_id = hxf.lin_id;
> > +	memcpy(lf.data, hxf.data, LIN_MAX_DLEN);
> > +	lf.checksum = hxf.checksum;
> > +	lf.checksum_mode = hxf.checksum_mode;
> > +
> > +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> > +		   lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> > +		   lf.checksum_mode ? "enhanced" : "classic");
> 
> nit: The indentation above is not quite right.
>      It should align to inside the opening '(' like this.
> 
> 	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> 		lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> 		lf.checksum_mode ? "enhanced" : "classic");
> 
> Flagged by checkpatch.

OK

> 
> ...
> 
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
> The type of req.baudrate is u16, a host byte-order type.
> But it is being assigned a little endian value.
> This does not seem right.
> 
> Flagged by Smatch.

In upcoming v4 I'll use __le16

> 
> > +
> > +	ret = hexlin_tx_req_status(priv, &req,
> > +				   sizeof(struct hexlin_baudrate_req));
> > +	if (ret)
> > +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +static int hexlin_probe(struct hid_device *hdev,
> > +			const struct hid_device_id *id)
> > +{
> > +	struct hexlin_priv_data *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->hid_dev = hdev;
> > +	hid_set_drvdata(hdev, priv);
> > +
> > +	mutex_init(&priv->tx_lock);
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "hid parse failed with %d\n", ret);
> > +		goto fail_and_free;
> > +	}
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_DRIVER);
> > +	if (ret) {
> > +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> > +		goto fail_and_stop;
> > +	}
> > +
> > +	ret = hid_hw_open(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> > +		goto fail_and_close;
> > +	}
> > +
> > +	init_completion(&priv->wait_in_report);
> > +
> > +	hid_device_io_start(hdev);
> > +
> > +	ret = init_hw(priv);
> > +	if (ret)
> > +		goto fail_and_close;
> > +
> > +	priv->ldev = register_lin(&hdev->dev, &hexlin_ldo);
> > +	if (IS_ERR_OR_NULL(priv->ldev)) {
> > +		ret = PTR_ERR(priv->ldev);
> > +		goto fail_and_close;
> 
> Is it intentional that when priv->ldev is NULL here,
> the function will return 0?
> 
> Flagged by Smatch.

IS_ERR_OR_NULL() gets IS_ERR() in upcoming v4

> 
> > +	}
> > +
> > +	hid_hw_close(hdev);
> > +
> > +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);
> > +
> > +	return 0;
> > +
> > +fail_and_close:
> > +	hid_hw_close(hdev);
> > +fail_and_stop:
> > +	hid_hw_stop(hdev);
> > +fail_and_free:
> > +	mutex_destroy(&priv->tx_lock);
> > +	return ret;
> > +}
> 
> ...

Thanks
  -- Christoph

