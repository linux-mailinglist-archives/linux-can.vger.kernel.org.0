Return-Path: <linux-can+bounces-491-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B28B2A19
	for <lists+linux-can@lfdr.de>; Thu, 25 Apr 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813E01F24154
	for <lists+linux-can@lfdr.de>; Thu, 25 Apr 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFA153809;
	Thu, 25 Apr 2024 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="D6I+DXvK"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6737143;
	Thu, 25 Apr 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078211; cv=none; b=Penixw2ZacX+pR3tRypPZKkMcyv7Nf+oweSDcQDRI4lrhEBvr2XFHyvxc7iCEZKG1Y5IdZrUrIDd06Wz9bKibzueJP3yzsKyQIjT7hEoCd3adC5W/Djgjng0LVcFxoLfmDHet6sLwykg+VE51YEySXMBbK22YlpzEqSaj4tY6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078211; c=relaxed/simple;
	bh=JlZ5SNw/c8lgIyAIwwqks3l+7NUsINRYRqt1oaRFElM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFepNOfz2xk945j5o00hvuB8jdFEaxGxplrnoFwZw7zGz0ViHWMd0HLNeZZG9XiJrlE1eHwPbPxKp691sBDW3Q+QNKR8VwJXbBAu3RQFSIJgb6P07e40z/POm4H15Grwg6tZ0A0D8FWBZjTJHdSGMU8hs2IbvmHjpjbC3lvQ3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=D6I+DXvK; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3++3z5ylpnDhpBpGdZfltMNRCAtctEtUSEKoliPaLzY=; b=D6I+DXvKKRGuwPZDMb6VKmy4bC
	j5tfqY470Lc3/nCQ7wW6qzi5cgyKnfljidykRQC+ZJZORWzXcILTnBzRP1LaVT7mnzovdJh5gRQkp
	lXRlbCV7SyncU4Sss0JSPj/R0yKlgaHhzhAQmD5U+TN7yD4TDC6+VNp3re/VNALVMUVY=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s062M-001PQI-05;
	Thu, 25 Apr 2024 22:49:46 +0200
Message-ID: <97b22f7e79540fe228250414452c6049a255f310.camel@hexdev.de>
Subject: Re: [PATCH 02/11] HID: hexLIN: Add support for USB LIN bus adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andreas Lauser <andreas.lauser@mercedes-benz.com>,
 Jonathan Corbet <corbet@lwn.net>,  linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Date: Thu, 25 Apr 2024 22:49:43 +0200
In-Reply-To: <5w4fhdfplmaowyiu7i327pziniwqnftgpn3ei6uttuezwgfgql@xnxikjjv6fob>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
	 <20240422065114.3185505-3-christoph.fritz@hexdev.de>
	 <5w4fhdfplmaowyiu7i327pziniwqnftgpn3ei6uttuezwgfgql@xnxikjjv6fob>
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

Hi Benjamin,

 thanks for your review, please see my answers below.

...
> > +
> > +static int hexlin_tx_req_status(struct hexlin_priv_data *priv,
> > +				const void *out_report, int len)
> > +{
> > +	int ret;
> > +	unsigned long t;
> > +
> > +	mutex_lock(&priv->tx_lock);
> 
> AFAICT, any operation using the device will use this function and
> therefore this is enforcing a single user at the same time.
> 
> Is this a bus or a hw limitation?

It's a hw limitation.

> > +
> > +	reinit_completion(&priv->wait_in_report);
> > +
> > +	ret = hexlin_tx_report(priv, out_report, len);
> > +	if (ret)
> > +		goto tx_exit;
> > +
> > +	t = wait_for_completion_killable_timeout(&priv->wait_in_report,
> > +						 msecs_to_jiffies(1000));
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
...
> > +static int hexlin_raw_event(struct hid_device *hdev,
> > +			    struct hid_report *report, u8 *data, int sz)
> > +{
> > +	struct hexlin_priv_data *priv;
> > +	int ret;
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
> > +		if (sz != 1)
> > +			return -EREMOTEIO;
> 
> Could we have some #define for all of these sizes (here and in all of
> the other branches)?

OK

> 
> > +		hid_dbg(hdev, "HEXLIN_SUCCESS: 0x%02x\n", data[0]);
> > +		complete(&priv->wait_in_report);
> 
> Shouldn't you ensure that you currently have a request pending?
> This works as long as no-one opens the hidraw node (see my remark
> below).

Thanks for the heads up, there is no need for hidraw.

> > +		break;
> > +	case HEXLIN_FAIL:
> > +		if (sz != 1)
> > +			return -EREMOTEIO;
> > +		hid_err(hdev, "HEXLIN_FAIL: 0x%02x\n", data[0]);
> > +		priv->is_error = true;
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_VERSION:
> > +		if (sz != 2)
> > +			return -EREMOTEIO;
> > +		priv->fw_version = data[1];
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_RESPONDER_ANSWER_ID:
> > +		if (sz != 20)
> > +			return -EREMOTEIO;
> > +		BUILD_BUG_ON(sizeof(priv->rar) != 20);
> 
> magical constants again

OK

> 
> > +		memcpy(&priv->rar, data, sizeof(priv->rar));
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	case HEXLIN_GET_BAUDRATE:
> > +		if (sz != 3)
> > +			return -EREMOTEIO;
> > +		BUILD_BUG_ON(sizeof(priv->baudrate) != 2);
> > +		memcpy(&priv->baudrate, &data[1], sizeof(priv->baudrate));
> > +		le16_to_cpus(priv->baudrate);
> > +		complete(&priv->wait_in_report);
> > +		break;
> > +	/* following cases not initiated by us, so no complete() */
> > +	case HEXLIN_FRAME:
> > +		if (sz != 17) {
> > +			hid_err_once(hdev, "frame size mismatch: %i\n", sz);
> > +			return -EREMOTEIO;
> > +		}
> > +		ret = hexlin_queue_frames_insert(priv, &data[1], sz-1);
> > +		if (ret) {
> > +			hid_err(hdev, "failed to add frame: %i\n", ret);
> > +			return ret;
> > +		}
> > +		break;
> > +	case HEXLIN_ERROR:
> > +		hid_err(hdev, "error from adapter\n");
> > +		break;
> > +	default:
> > +		hid_err(hdev, "unknown event: 0x%02x\n", data[0]);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int init_hw(struct hexlin_priv_data *priv)
> > +{
> > +	int ret;
> > +
> > +	ret = hexlin_reset_dev(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hexlin_get_version(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->baudrate = LIN_DEFAULT_BAUDRATE;
> > +	ret = hexlin_set_baudrate(priv, priv->baudrate);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
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
> > +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> 
> Are you sure you want HID_CONNECT_HIDRAW?
> 
> Given that your whole driver relies on the assumption that any command
> sent to the device is guarded by the mutex, if one client opens the
> hidraw node and starts sending commands behind your back you are
> screwed...
> 
> Maybe use HID_CONNECT_DRIVER instead.

HID_CONNECT_DRIVER it is

> 
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
> > +	}
> > +
> > +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);
> 
> you are not calling hid_hw_close(hdev) here (on purpose I guess).
> 
> However, this prevents the device to enter any sleep mode as the kernel
> will always consider it to be in use.
> Is there some open/close mechanism in LIN or in CAN that can tell the
> device that it needs to be opened or do we assume that the device needs
> to be powered on all the time?

One can bring the LIN device up and down, just like any other Ethernet
or CAN device. So, for revision 2 of this patchset, I added open/stop
handling. This allows for hid_hw_close(hdev) here and also makes
remove() handling way easier. Thanks for the heads up.

> 
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
> > +
> > +static void hexlin_remove(struct hid_device *hdev)
> > +{
> > +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> > +
> > +	complete(&priv->wait_in_report);
> 
> what if you get one LIN request just now, between those 2 calls?
> 
> You should probably disable the ability to take the mutex before sending
> the complete call above or you might still have the mutex taken here.
> 
> Also shouldn't you set priv->is_error = true before the complete?
> 
> > +	unregister_lin(priv->ldev);
> > +	hid_hw_close(hdev);
> > +	hid_hw_stop(hdev);
> > +	mutex_destroy(&priv->tx_lock);
> 
> Given how the device works, I think it would be safer to do this in the
> following order:
> 
> // prevent any incoming event (assuming hidraw is not available)
> hid_hw_close(hdev);
> // ensure the device is powered off
> hid_hw_stop(hdev);
> // mark any pending request as failed
> priv->is_error = true;
> // mark the device as unusable
> priv->removed = true;
> complete(&priv->wait_in_report);
> // unregister
> unregister_lin(priv->ldev);
> // mutex is not used anymore
> mutex_destroy(&priv->tx_lock);
> 
> (I might be wrong but this seems more sensible to me).
> 
> Actually, instead of having a priv->removed boolean, you could also take
> and release the mutex before releasing it, this way you are sure to not
> be in the critical code section. This should work because you are using
> wait_for_completion_killable_timeout() and so after 1 s you are
> guaranteed to exit the mutex.

Thanks for the great explanation.

> > +}
> > +
> > +static const struct hid_device_id hexlin_table[] = {
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_HEXLIN) },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(hid, hexlin_table);
> > +
> > +static struct hid_driver hexlin_driver = {
> > +	.name = "hexLIN",
> > +	.id_table = hexlin_table,
> > +	.probe = hexlin_probe,
> > +	.remove = hexlin_remove,
> > +	.raw_event = hexlin_raw_event,
> > +};
> > +
> > +static int __init hexlin_init(void)
> > +{
> > +	return hid_register_driver(&hexlin_driver);
> > +}
> > +
> > +static void __exit hexlin_exit(void)
> > +{
> > +	hid_unregister_driver(&hexlin_driver);
> > +}
> > +
> > +/*
> > + * When compiled into the kernel, initialize after the hid bus.
> > + */
> > +late_initcall(hexlin_init);
> > +module_exit(hexlin_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> > +MODULE_DESCRIPTION("LIN bus driver for hexLIN USB adapter");
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 8376fb5e2d0b4..157d234e1d400 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -903,6 +903,7 @@
> >  #define USB_DEVICE_ID_MCC_PMD1208LS	0x007a
> >  
> >  #define USB_VENDOR_ID_MCS		0x16d0
> > +#define USB_DEVICE_ID_MCS_HEXLIN	0x0648
> >  #define USB_DEVICE_ID_MCS_GAMEPADBLOCK	0x0bcc
> >  
> >  #define USB_VENDOR_MEGAWORLD		0x07b5
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > index e0bbf0c6345d6..328fcc61303f3 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -436,6 +436,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
> >  #endif
> > +#if IS_ENABLED(CONFIG_HID_HEXLIN)
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_HEXLIN) },
> 
> Generally, the pattern for drivers in the HID subsystem is to rely on
> the vendor name, not the product, in order to be able to extend it to
> more than one product.
> 
> Is your vendor name MCS? Or Hexdev?
> 
> If so, the driver should likely be hid-hexdev.c...

We got the PID from MCS online shop here:

https://www.mcselec.com/index.php?page=shop.product_details&product_id=92&option=com_phpshop

Our vendor name is hexDEV, but the USB VID is MCS, and the product name
is hexLIN...

So is 'hid-hexlin.c' or 'hid-hexdev-hexlin.c' okay or does it need to
be named 'hid-mcs-hexlin.c' in spite MCS has nearly nothing to do with
it?


Cheers
  -- Christoph


