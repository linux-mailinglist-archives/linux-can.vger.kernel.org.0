Return-Path: <linux-can+bounces-606-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF48C1376
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987A8B20A82
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27110A39;
	Thu,  9 May 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="McdZtr87"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5008F7A;
	Thu,  9 May 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274426; cv=none; b=Dlh7cVj21VHYRgwJGn8iWh4rDp9U4bBG+OxiCmsbtXqqSQgrQpiHMmPl7kGZxtTIipjSiF2LM7UerXz0xsCTnFNAlsM/BFEeR4t9eQ7Qs47UNzM5SrGVCJ4Oo8RlnU6YjRYEqCarzdi86JEcvf3/ECnRU/nvtIdhdAuiNl49cvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274426; c=relaxed/simple;
	bh=S3kMTQVwqtDURyBEOghwDAdbtJxYe8b4c7tzHHDHs+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtalguQbZan4n2Nom0vn1jAdMt1JMU3qQ3MdbUJ/nOQbJ6qGISGJtl+9zlCozXP4NxxgMqm2QoefoChyFy1wwjBoXqbKkyBZbbk+I1x0Npf3fE2Z0s86A6QPDgJoHO0vDwAj+vbl104B+JnES9uLiYAUzqP0aLY8We/2vVU7/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=McdZtr87; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UOWgAtAldSumHJVAZsK0IZJ/TI4CUCDKib1dHqAc+eg=; b=McdZtr87SdPl7lnJCD2vcbhDWy
	Wnp8XY8MJzKv8AiyFIFI0YyQDPc+Ekmutdo+W0zgcXFV+xFZNBD02RTXwFRFnPSjEYmmZNLOeMEo4
	89VWQjZKibi6dIFkDvQDg2BvuYgwYiUl4KjEcL7VWYHQrB4vt9J1NUlhIqyfoY+6t3VE=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57EJ-001jbm-2s;
	Thu, 09 May 2024 19:06:52 +0200
Message-ID: <bbb1d7b8ad4c55b21619e79987c08375cbdbd3c7.camel@hexdev.de>
Subject: Re: [PATCH v3 07/11] can: Add support for serdev LIN adapters
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
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Thu, 09 May 2024 19:06:50 +0200
In-Reply-To: <71837e7a-b0cf-a8ff-788f-50ba68313621@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-8-christoph.fritz@hexdev.de>
	 <71837e7a-b0cf-a8ff-788f-50ba68313621@linux.intel.com>
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

On Mon, 2024-05-06 at 20:03 +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Christoph Fritz wrote:
> 
> > This commit introduces LIN-Bus support for UART devices equipped with
> > LIN transceivers, utilizing the Serial Device Bus (serdev) interface.
> > 
> > For more details on an adapter, visit: https://hexdev.de/hexlin#tty
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  drivers/net/can/Kconfig      |  16 ++
> >  drivers/net/can/Makefile     |   1 +
> >  drivers/net/can/lin-serdev.c | 500 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 517 insertions(+)
> >  create mode 100644 drivers/net/can/lin-serdev.c
> > 
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index 0934bbf8d03b2..91c6cdeefe440 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -181,6 +181,22 @@ config CAN_LIN
> >  
> >  	  Actual device drivers need to be enabled too.
> >  
> > +config CAN_LIN_SERDEV
> > +	tristate "Serial LIN Adaptors"
> > +	depends on CAN_LIN && SERIAL_DEV_BUS && OF
> > +	help
> > +	  LIN-Bus support for serial devices equipped with LIN transceievers.
> > +	  This device driver is using CAN_LIN for a userland connection on
> > +	  one side and the kernel its serial device bus (serdev) interface
> > +	  on the other side.
> > +
> > +	  If you have a hexlin tty adapter, say Y here and see
> > +	  <https://hexdev.de/hexlin#tty>.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called lin-serdev.ko.
> > +
> > +
> >  config CAN_SLCAN
> >  	tristate "Serial / USB serial CAN Adaptors (slcan)"
> >  	depends on TTY
> > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > index 0093ee9219ca8..21ca514a42439 100644
> > --- a/drivers/net/can/Makefile
> > +++ b/drivers/net/can/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
> >  obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
> >  obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
> >  obj-$(CONFIG_CAN_LIN)		+= lin.o
> > +obj-$(CONFIG_CAN_LIN_SERDEV)	+= lin-serdev.o
> >  obj-$(CONFIG_CAN_MSCAN)		+= mscan/
> >  obj-$(CONFIG_CAN_M_CAN)		+= m_can/
> >  obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
> > diff --git a/drivers/net/can/lin-serdev.c b/drivers/net/can/lin-serdev.c
> > new file mode 100644
> > index 0000000000000..13fd9a54c6c93
> > --- /dev/null
> > +++ b/drivers/net/can/lin-serdev.c
> > @@ -0,0 +1,500 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/serdev.h>
> > +#include <linux/slab.h>
> > +#include <linux/tty.h>
> > +#include <net/lin.h>
> > +
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
> > +	unsigned long break_usleep_min;
> > +	unsigned long break_usleep_max;
> > +	unsigned long post_break_usleep_min;
> > +	unsigned long post_break_usleep_max;
> > +	unsigned long force_timeout_jfs;
> > +	struct lin_responder_answer respond_answ[LIN_NUM_IDS];
> > +	struct mutex resp_lock; /* protects respond_answ */
> > +	bool is_stopped;
> > +};
> > +
> > +static int linser_open(struct lin_device *ldev)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +	int ret;
> > +
> > +	if (priv->is_stopped) {
> > +		ret = serdev_device_open(serdev);
> > +		if (ret) {
> > +			dev_err(&serdev->dev, "Unable to open device\n");
> > +			return ret;
> > +		}
> > +
> > +		serdev_device_set_flow_control(serdev, false);
> > +		serdev_device_set_break_detection(serdev, true);
> > +
> > +		priv->is_stopped = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int linser_stop(struct lin_device *ldev)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +
> > +	if (priv->is_stopped)
> > +		return 0;
> > +
> > +	serdev_device_close(serdev);
> > +	priv->is_stopped = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int linser_send_break(struct linser_priv *priv)
> > +{
> > +	struct serdev_device *serdev = priv->serdev;
> > +	int ret;
> > +
> > +	ret = serdev_device_break_ctl(serdev, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(priv->break_usleep_min, priv->break_usleep_max);
> > +
> > +	ret = serdev_device_break_ctl(serdev, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(priv->post_break_usleep_min, priv->post_break_usleep_max);
> > +
> > +	return 0;
> > +}
> > +
> > +static int linser_ldo_tx(struct lin_device *ldev, const struct lin_frame *lf)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +	u8 pid = LIN_FORM_PID(lf->lin_id);
> > +	u8 buf[LINSER_TX_BUFFER_SIZE];
> > +	ssize_t written_len, total_len;
> > +	u8 checksum;
> > +	int ret;
> > +
> > +	if (lf->len + 3 > LINSER_TX_BUFFER_SIZE) {
> > +		dev_err(&serdev->dev, "Frame length %u exceeds buffer size\n", lf->len);
> > +		return -EINVAL;
> > +	}
> > +
> > +	buf[0] = LIN_SYNC_BYTE;
> > +	buf[1] = pid;
> > +	total_len = 2;
> > +
> > +	if (lf->len) {
> > +		memcpy(&buf[2], lf->data, lf->len);
> > +		checksum = lin_get_checksum(pid, lf->len, lf->data,
> > +					    lf->checksum_mode);
> > +		buf[lf->len + 2] = checksum;
> > +		total_len += lf->len + 1;
> > +	}
> > +
> > +	ret = linser_send_break(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	written_len = serdev_device_write(serdev, buf, total_len, 0);
> > +	if (written_len < total_len)
> > +		return written_len < 0 ? (int)written_len : -EIO;
> > +
> > +	dev_dbg(&serdev->dev, "sent out: %*ph\n", (int)total_len, buf);
> > +
> > +	serdev_device_wait_until_sent(serdev, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void linser_derive_timings(struct linser_priv *priv, u16 bitrate)
> > +{
> > +	unsigned long break_baud = (bitrate * 2) / 3;
> > +	unsigned long timeout_us;
> > +
> > +	priv->break_usleep_min = (USEC_PER_SEC * LINSER_SAMPLES_PER_CHAR) /
> > +				 break_baud;
> > +	priv->break_usleep_max = priv->break_usleep_min + 50;
> > +	priv->post_break_usleep_min = (USEC_PER_SEC * 1 /* 1 bit */) / break_baud;
> 
> Don't mix comments and code like this.

OK

> 
> > +	priv->post_break_usleep_max = priv->post_break_usleep_min + 30;
> > +
> > +	timeout_us = DIV_ROUND_CLOSEST(USEC_PER_SEC * 256 /* bit */, bitrate);
> 
> Ditto.

OK

> 
> > +	priv->force_timeout_jfs = usecs_to_jiffies(timeout_us);
> > +}
> > +
> > +static int linser_update_bitrate(struct lin_device *ldev, u16 bitrate)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +	unsigned int speed;
> > +	int ret;
> > +
> > +	ret = linser_open(ldev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	speed = serdev_device_set_baudrate(serdev, bitrate);
> > +	if (!bitrate || speed != bitrate)
> > +		return -EINVAL;
> > +
> > +	linser_derive_timings(priv, bitrate);
> > +
> > +	return 0;
> > +}
> > +
> > +static int linser_get_responder_answer(struct lin_device *ldev, u8 id,
> > +				       struct lin_responder_answer *answ)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +	struct lin_responder_answer *r = &priv->respond_answ[id];
> > +
> > +	if (!answ)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->resp_lock);
> 
> guard(mutex)(&priv->resp_lock);

OK

> 
> > +	memcpy(answ, r, sizeof(struct lin_responder_answer));
> 
> sizeof(*answ);

OK

> 
> > +	mutex_unlock(&priv->resp_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int linser_update_resp_answer(struct lin_device *ldev,
> > +				     const struct lin_responder_answer *answ)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> > +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> > +	struct lin_responder_answer *r = &priv->respond_answ[answ->lf.lin_id];
> > +
> > +	if (!answ)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->resp_lock);
> > +	memcpy(r, answ, sizeof(struct lin_responder_answer));
> 
> Ditto.

OK

> 
> > +	r->lf.checksum = lin_get_checksum(LIN_FORM_PID(answ->lf.lin_id),
> > +					  answ->lf.len,
> > +					  answ->lf.data,
> > +					  answ->lf.checksum_mode);
> > +	mutex_unlock(&priv->resp_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct lin_device_ops linser_lindev_ops = {
> > +	.ldo_open = linser_open,
> > +	.ldo_stop = linser_stop,
> > +	.ldo_tx = linser_ldo_tx,
> > +	.update_bitrate = linser_update_bitrate,
> > +	.get_responder_answer = linser_get_responder_answer,
> > +	.update_responder_answer = linser_update_resp_answer,
> > +};
> > +
> > +static bool linser_tx_frame_as_responder(struct linser_priv *priv, u8 id)
> > +{
> > +	struct lin_responder_answer *answ = &priv->respond_answ[id];
> > +	struct serdev_device *serdev = priv->serdev;
> > +	u8 buf[LINSER_TX_BUFFER_SIZE];
> > +	u8 checksum, count, n;
> > +	ssize_t write_len;
> > +
> > +	mutex_lock(&priv->resp_lock);
> 
> scoped_guard() can be used here.

OK

> 
> > +
> > +	if (!answ->is_active) {
> > +		mutex_unlock(&priv->resp_lock);
> > +		return false;
> > +	}
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
> > +			mutex_unlock(&priv->resp_lock);
> > +			return false;
> 
> Use reverse logic so you can reduce indent.

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
> > +}
> > +
> > +static void linser_pop_fifo(struct linser_priv *priv, size_t n)
> > +{
> > +	for (size_t i = 0; i < n; i++)
> > +		kfifo_skip(&priv->rx_fifo);
> > +}
> > +
> > +static int linser_fill_frame(struct linser_priv *priv, struct lin_frame *lf)
> > +{
> > +	struct serdev_device *serdev = priv->serdev;
> > +	struct linser_rx buf[LINSER_PARSE_BUFFER];
> > +	unsigned int count, i, brk = 0;
> > +
> > +	count = kfifo_out_peek(&priv->rx_fifo, buf, LINSER_PARSE_BUFFER);
> > +
> > +	memset(lf, 0, sizeof(struct lin_frame));
> > +
> > +	for (i = 0; i < count; i++) {
> > +		dev_dbg(&serdev->dev, "buf[%d]: data=%02x, flag=%02x\n",
> > +			i, buf[i].data, buf[i].flag);
> > +	}
> > +
> > +	if (count < 3)
> > +		return NEED_MORE;
> > +
> > +	if (buf[0].flag != TTY_BREAK || buf[1].data != LIN_SYNC_BYTE) {
> > +		linser_pop_fifo(priv, 1); /* pop incorrect start */
> > +		return NEED_MORE;
> > +	} else if (!LIN_CHECK_PID(buf[2].data)) {
> > +		linser_pop_fifo(priv, 3); /* pop incorrect header */
> > +		return NEED_MORE;
> > +	}
> > +
> > +	lf->lin_id = LIN_GET_ID(buf[2].data);
> > +
> > +	/* from here on we do have a correct LIN header */
> > +
> > +	if (count == 3)
> > +		return linser_tx_frame_as_responder(priv, lf->lin_id) ?
> > +		       NEED_MORE : NEED_FORCE;
> > +
> > +	for (i = 3; i < count && i < LINSER_PARSE_BUFFER && i < 12; i++) {
> > +		if (buf[i].flag == TTY_BREAK) {
> > +			brk = i;
> > +			break;
> > +		}
> > +		lf->len++;
> > +	}
> > +	if (lf->len)
> > +		lf->len -= 1; /* account for checksum */
> > +
> > +	if (brk == 3)
> > +		return MODE_OK;
> > +
> > +	if (brk == 4) {
> > +		/* suppress wrong answer data-byte in between PID and break
> > +		 * because checksum is missing
> > +		 */
> > +		return MODE_OK;
> > +	}
> > +
> > +	for (i = 0; i < lf->len; i++)
> > +		lf->data[i] = buf[3 + i].data;
> > +	lf->checksum = buf[2 + lf->len + 1].data;
> > +	mutex_lock(&priv->resp_lock);
> > +	lf->checksum_mode = priv->respond_answ[lf->lin_id].lf.checksum_mode;
> > +	mutex_unlock(&priv->resp_lock);
> > +
> > +	dev_dbg(&serdev->dev, "brk:%i, len:%u, data:%*ph, checksum:%x (%s)\n",
> > +		brk, lf->len, lf->len, lf->data, lf->checksum,
> > +		lf->checksum_mode ? "enhanced" : "classic");
> > +
> > +	if (brk > 4)
> > +		return MODE_OK;	/* frame in between two breaks: so complete */
> > +
> > +	if (lf->len == 8)
> > +		return MODE_OK;
> > +
> > +	return NEED_FORCE;
> > +}
> > +
> > +static int linser_process_frame(struct linser_priv *priv, bool force)
> > +{
> > +	struct serdev_device *serdev = priv->serdev;
> > +	struct lin_frame lf;
> > +	size_t bytes_to_pop;
> > +	int ret = NEED_MORE;
> > +
> > +	while (kfifo_len(&priv->rx_fifo) >= LIN_HEADER_SIZE) {
> > +		ret = linser_fill_frame(priv, &lf);
> > +
> > +		if (ret == MODE_OK || (ret == NEED_FORCE && force)) {
> > +			dev_dbg(&serdev->dev, "lin_rx: %s\n",
> > +				force ? "force" : "normal");
> > +			lin_rx(priv->lin_dev, &lf);
> > +			bytes_to_pop = LIN_HEADER_SIZE + lf.len +
> > +				       (lf.len ? 1 : 0);
> > +			linser_pop_fifo(priv, bytes_to_pop);
> > +			force = false;
> > +			ret = MODE_OK;
> > +		} else {
> > +			return ret;
> 
> Reverse logic & deindent the main block.

OK

...

thanks
  -- Christoph


