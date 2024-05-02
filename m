Return-Path: <linux-can+bounces-539-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D28BA035
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC461F23625
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24A173334;
	Thu,  2 May 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="oDSpHg5X"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4D171669;
	Thu,  2 May 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674004; cv=none; b=s0mrBJOmd2y61NeTWn0Ruyx8Zu1m7s3npGXcXjzKhwpVXCOqXrcBsZcruz1er809HOmICSMwHF63iY1deTazc0jq6pu6FVSfDVI406SCSO+hl/fM/xZVbXrvimDqyaSTX0h5PofE3/PQ3+YcfcXtFsOgX5+ZHdRRPYwloyH/4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674004; c=relaxed/simple;
	bh=DkDZ0BO2Nq2CclwEjcWx28N5dvPWqQoQyz/ra0jAc6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAbSrr3lSytH9jH62cf3ee+iFBsrj0SrnK6PoT+bvdHq8/+sXUyjksShnWnMVrqUZiWK4Vq/n6hq7tzT1u/SYuUKicjMHGXdj8B4c7oSkV2F5Mhuf5cxRqFA4oDT/zxqP8oJXZANlUe0AXbO7pNonUc9UnQ2faTrIihhUotpo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=oDSpHg5X; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yGgKhs0asb1Y2UFT7ihSdsoF/Rm6jsqksB68r4YXvWE=; b=oDSpHg5X2es8aMHxNsxiUoUGVt
	fPSG/h6J+tNXV9K0vQPdUbbfbMvw8txbZtZaUFOkszJaoj/vMXh1CB1dDhuft34SzDYFX4HoUILay
	w4e1mJL5CCXYxmqaFrQULwU9a5MZc4YT43oWwIG4qox8XbP0WNQNMmFTbBqI8UumLwPo=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2b26-001ZZf-0X;
	Thu, 02 May 2024 20:19:50 +0200
Message-ID: <1359a0e5024445d0e2bc1c8659094c35dc85c090.camel@hexdev.de>
Subject: Re: [PATCH v2 07/12] can: Add support for serdev LIN adapters
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Thu, 02 May 2024 20:19:48 +0200
In-Reply-To: <6ae3c1af-4368-4a3e-bfb5-366080048dac@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-8-christoph.fritz@hexdev.de>
	 <6ae3c1af-4368-4a3e-bfb5-366080048dac@kernel.org>
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

On Thu, 2024-05-02 at 10:44 +0200, Jiri Slaby wrote:
> On 02. 05. 24, 9:55, Christoph Fritz wrote:
> > This commit introduces LIN-Bus support for UART devices equipped with
> > LIN transceivers, utilizing the Serial Device Bus (serdev) interface.
> > 
> > For more details on an adapter, visit: https://hexdev.de/hexlin#tty
> ...
> > --- /dev/null
> > +++ b/drivers/net/can/lin-serdev.c
> > @@ -0,0 +1,514 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> > +
> > +#include <linux/module.h>
> > +#include <linux/wait.h>
> > +#include <linux/init.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/kernel.h>
> 
> What do you need kernel.h for? You should explicitly require what you 
> need (you apparently do), so kernel.h should not be needed.

OK

> 
> > +#include <net/lin.h>
> > +#include <linux/of.h>
> > +#include <linux/serdev.h>
> > +#include <linux/slab.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/tty.h>
> 
> Might be eaier to maintain if you sort them.

OK, hid driver gets also sorted

> 
> > +#define LINSER_SAMPLES_PER_CHAR		10
> > +#define LINSER_TX_BUFFER_SIZE		11
> > +#define LINSER_RX_FIFO_SIZE		256
> > +#define LINSER_PARSE_BUFFER		24
> > +
> > +struct linser_rx {
> > +	u8 data;
> > +	u8 flag;
> > +};
> > +
> > +enum linser_rx_status {
> > +	NEED_MORE = -1,
> > +	MODE_OK = 0,
> > +	NEED_FORCE,
> > +};
> > +
> > +struct linser_priv {
> > +	struct lin_device *lin_dev;
> > +	struct serdev_device *serdev;
> > +	DECLARE_KFIFO_PTR(rx_fifo, struct linser_rx);
> > +	struct delayed_work rx_work;
> > +	ulong break_usleep_min;
> > +	ulong break_usleep_max;
> > +	ulong post_break_usleep_min;
> > +	ulong post_break_usleep_max;
> > +	ulong force_timeout_jfs;
> 
> The same as for uint :)

OK

> 
> > +	struct lin_responder_answer respond_answ[LIN_NUM_IDS];
> > +	struct mutex resp_lock; /* protects respond_answ */
> > +	bool is_stopped;
> > +};
> ...
> > +static void linser_derive_timings(struct linser_priv *priv, u16 bitrate)
> > +{
> > +	unsigned long break_baud = (bitrate * 2) / 3;
> > +	unsigned long timeout_us;
> > +
> 
> Are those 1000000UL USEC_PER_SEC?

yes

> 
> > +	priv->break_usleep_min = (1000000UL * LINSER_SAMPLES_PER_CHAR) /
> > +				 break_baud;
> > +	priv->break_usleep_max = priv->break_usleep_min + 50;
> > +	priv->post_break_usleep_min = (1000000UL * 1 /* 1 bit */) / break_baud;
> > +	priv->post_break_usleep_max = priv->post_break_usleep_min + 30;
> > +
> > +	timeout_us = DIV_ROUND_CLOSEST(1000000UL * 256 /* bit */, bitrate);
> > +	priv->force_timeout_jfs = usecs_to_jiffies(timeout_us);
> > +}
> ...
> > +static bool linser_tx_frame_as_responder(struct linser_priv *priv, u8 id)
> > +{
> > +	struct lin_responder_answer *answ = &priv->respond_answ[id];
> > +	struct serdev_device *serdev = priv->serdev;
> > +	u8 buf[LINSER_TX_BUFFER_SIZE];
> > +	u8 checksum, count, n;
> > +	ssize_t write_len;
> > +
> > +	mutex_lock(&priv->resp_lock);
> > +
> > +	if (!answ->is_active)
> > +		goto unlock_and_exit_false;
> > +
> > +	if (answ->is_event_frame) {
> > +		struct lin_responder_answer *e_answ;
> > +
> > +		e_answ = &priv->respond_answ[answ->event_associated_id];
> > +		n = min(e_answ->lf.len, LIN_MAX_DLEN);
> > +		if (memcmp(answ->lf.data, e_answ->lf.data, n) != 0) {
> > +			memcpy(answ->lf.data, e_answ->lf.data, n);
> > +			checksum = lin_get_checksum(LIN_FORM_PID(answ->lf.lin_id),
> > +						    n, e_answ->lf.data,
> > +						    answ->lf.checksum_mode);
> > +			answ = e_answ;
> > +		} else {
> > +			goto unlock_and_exit_false;
> 
> Can't you simply use guard(mutex) above and avoid the error-prone 
> gotos/cleanup completely?

OK

> 
> > +		}
> > +	} else {
> > +		checksum = answ->lf.checksum;
> > +	}
> > +
> > +	count = min(answ->lf.len, LIN_MAX_DLEN);
> > +	memcpy(&buf[0], answ->lf.data, count);
> > +	buf[count] = checksum;
> > +
> > +	mutex_unlock(&priv->resp_lock);
> > +
> > +	write_len = serdev_device_write(serdev, buf, count + 1, 0);
> > +	if (write_len < count + 1)
> > +		return false;
> > +
> > +	serdev_device_wait_until_sent(serdev, 0);
> > +
> > +	return true;
> > +
> > +unlock_and_exit_false:
> > +	mutex_unlock(&priv->resp_lock);
> > +	return false;
> > +}
> > +
> > +static void linser_pop_fifo(struct linser_priv *priv, size_t n)
> > +{
> > +	struct serdev_device *serdev = priv->serdev;
> > +	struct linser_rx dummy;
> > +	size_t ret, i;
> > +
> > +	for (i = 0; i < n; i++) {
> > +		ret = kfifo_out(&priv->rx_fifo, &dummy, 1);
> 
> Does kfifo_skip() not work for records? (I added it recently for serial.)

Using kfifo_skip() greatly simplifies this function and it works for
records (uses __kfifo_skip_r), tests are successful.

Maybe the comment in kfifo.h could be made more clear from:

 "kfifo_skip - skip output data"
to
 "kfifo_skip - skip the next fifo record"

> 
> > +		if (ret != 1) {
> > +			dev_err(&serdev->dev, "Failed to pop from FIFO\n");
> > +			break;
> > +		}
> > +	}
> > +}
> 

Let me address these points and reroll in v3.

Thanks
  -- Christoph

