Return-Path: <linux-can+bounces-560-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB278BBBA4
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B631F21E71
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3F22611;
	Sat,  4 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qscErA/o"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9B1C695;
	Sat,  4 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827519; cv=none; b=oDm4mZZ6L6C1MOGwPgsi1oBkpKQfpdILPj2GXdxMG2WD+tgbM3dQK9ZhxpPQE5OmxBImt2RFuY3NKQnq+jwAYB0N4SCxKKhOoZafth7nG/lA3xwEHsST6UOZxnMxEdj1ChcumjCVfBmT2FKq/pGLpNeg8nG4T8U2Evc3kVmGFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827519; c=relaxed/simple;
	bh=mtwrT6ZE9KkICl5n7f/pg932gWXUupz2bBQvgv+yS6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djtzClQOZIGmJO/lJN15yF6ZxGDdHXojq8B0fYitknfJqnJ8FfnerbaW4lwWFtXo/wwRpMyfe/BJhqoRPDlnD5VDHoEfKKfz0JUu3RllaSzhVIxPgA7o8lIDVP9Ci1g7GzqN0xYUuw2kyQTBfn3mCc50TlHNDauVi/341CWUH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qscErA/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD165C072AA;
	Sat,  4 May 2024 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714827519;
	bh=mtwrT6ZE9KkICl5n7f/pg932gWXUupz2bBQvgv+yS6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qscErA/oKnTA6CTMZpNEo5WtO76hv+bPuLHntXRxAxLx+1RG954gNta9DFFbeKtx8
	 3Ooirkye4fNKbiLqOBIljZLXslA7YDecs7REaQboGgrEOqH6LCTAu0KYusxmDny5gH
	 xC7TYCDOczc5+8S8pwnralh21o89tNlKbiurCnMVp9UDktcv0bUBBXReJRBID2+ZcV
	 /K6EezNpeknKOfSqTUPvLQcaCYjIxgcSwOdiiIenyIQzHQS4/9lvssfL7PXByf36cU
	 kAyzmKe5Q7BEULXhT24jfWixEhoD4bS+RWGy+2wLrC7kG4jdpMsnOKK6PvodzVYAqv
	 sEA7fVq2Avpbg==
Date: Sat, 4 May 2024 13:58:28 +0100
From: Simon Horman <horms@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 02/12] HID: hexLIN: Add support for USB LIN bus adapter
Message-ID: <20240504125828.GK3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-3-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502075534.882628-3-christoph.fritz@hexdev.de>

On Thu, May 02, 2024 at 09:55:24AM +0200, Christoph Fritz wrote:
> This patch introduces driver support for the hexLIN USB LIN bus adapter,
> enabling LIN communication over USB for both controller and responder
> modes. The driver interfaces with the CAN_LIN framework for userland
> connectivity.
> 
> For more details on the adapter, visit: https://hexdev.de/hexlin/
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>

Hi Christoph,

Some minor feedback from my side.

...

> diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c

...

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
> +	le32_to_cpus(hxf.flags);
> +
> +	lf.len = hxf.len;
> +	lf.lin_id = hxf.lin_id;
> +	memcpy(lf.data, hxf.data, LIN_MAX_DLEN);
> +	lf.checksum = hxf.checksum;
> +	lf.checksum_mode = hxf.checksum_mode;
> +
> +	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> +		   lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> +		   lf.checksum_mode ? "enhanced" : "classic");

nit: The indentation above is not quite right.
     It should align to inside the opening '(' like this.

	hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
		lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
		lf.checksum_mode ? "enhanced" : "classic");

Flagged by checkpatch.

...

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

The type of req.baudrate is u16, a host byte-order type.
But it is being assigned a little endian value.
This does not seem right.

Flagged by Smatch.

> +
> +	ret = hexlin_tx_req_status(priv, &req,
> +				   sizeof(struct hexlin_baudrate_req));
> +	if (ret)
> +		hid_err(priv->hid_dev, "%s failed with %d\n", __func__, ret);
> +
> +	return ret;
> +}

...

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

Is it intentional that when priv->ldev is NULL here,
the function will return 0?

Flagged by Smatch.

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

...

