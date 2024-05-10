Return-Path: <linux-can+bounces-627-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B68C26E4
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FF42866C8
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C00811E9;
	Fri, 10 May 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5covMGx"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07338D;
	Fri, 10 May 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351563; cv=none; b=bLFJUyah/SBEHJJamHXNpiD1BfF8q02pwqtiAp65f29/wOwnroVJnPME1WAB4kNflH0jzuD4+AkYHCEeKyBCv5OD4ATpUPBv7fDDsCy54l/zMVP0hKWYIFw+iN1eJf2Pu1MW41ySvkSuvUaJybadte6/ON2ZE1dLvrGO9Cz5muU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351563; c=relaxed/simple;
	bh=OyQx8duQm9hg8aX7eKlNxWpT4KFgG8uAqjkUxkYAf9g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R32iZWR3tP4aRJ2JU+xnKgGeheLnOdG9Nz7110DIbz7UfuAu2mfxFd6PZ/U2TZNiHmoJ9WmZrR4YoyY+dpOaMtrXNqwyzETTGnHUvx1G88Si0DNW3EN76F3VkscVMgfm0u3nDdjRuTf/d0F3CAX5E8ew139gNxCM0k4D4HvHwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5covMGx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351562; x=1746887562;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OyQx8duQm9hg8aX7eKlNxWpT4KFgG8uAqjkUxkYAf9g=;
  b=V5covMGxSjPhAUcJhe6X8/WN2Mad0IhsqjZLIjDg9HyI3+NT62HTWxeB
   BhvLMFdSoS62QDGWUtk6N9il7yvh+roSYZ0o4rYdjCjtuxJ7680XhdOlW
   Gtp6+ItdM1vyfX/xKul6MFE4cfOviDnRbHmdonrlsljf3fv6aSmI2ITda
   s09BvnOZzIXYZOTfxlp5iGY5AfmoIUK5sRGSIdeAjXpTYNepNY8NqxfWO
   heyODlNvreDkP+VAObyEGKVnY2YA49xF90RwZ2HSYXIIQCnf48n0PJW+4
   XgkDTTqVjpG8tPRYGk5cpdS15lFEzrqlMTKsUOI3nNh+9ukb1umYn+IzP
   Q==;
X-CSE-ConnectionGUID: VWvbVRpqQoulJZBr5ua9EA==
X-CSE-MsgGUID: uFKQnzfDReGeP88hyP81Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="33846247"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="33846247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:32:41 -0700
X-CSE-ConnectionGUID: viL66+41TVSr/Em7zPTpyw==
X-CSE-MsgGUID: V6HV30O6Q7iaUG8D2/Vx0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="60803332"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:32:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 17:32:28 +0300 (EEST)
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
Subject: Re: [PATCH v4 07/11] can: Add support for hexDEV serial LIN adapter
 hexLINSER
In-Reply-To: <20240509171736.2048414-8-christoph.fritz@hexdev.de>
Message-ID: <d0884a05-7f38-7026-4f3b-fd50d9133a26@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-8-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Christoph Fritz wrote:

> Introduce support for the hexDEV serial LIN adapter hexLINSER. These
> devices are equipped with LIN transceivers and are mostly hard-wired to
> serial devices.
> 
> This device driver uses CAN_LIN on one side and the serial device bus
> (serdev) interface on the other.
> 
> For more details on the adapter, visit: https://hexdev.de/hexlin#hexLINSER
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/net/can/Kconfig      |  15 ++
>  drivers/net/can/Makefile     |   1 +
>  drivers/net/can/hex-linser.c | 505 +++++++++++++++++++++++++++++++++++
>  3 files changed, 521 insertions(+)
>  create mode 100644 drivers/net/can/hex-linser.c
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 0934bbf8d03b2..141972d6bbf1e 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -181,6 +181,21 @@ config CAN_LIN
>  
>  	  Actual device drivers need to be enabled too.
>  
> +config CAN_LIN_HEXLINSER
> +	tristate "hexDEV hexLINSER serial LIN Adaptors"
> +	depends on CAN_LIN && SERIAL_DEV_BUS && OF
> +	help
> +	  LIN support for serial devices equipped with LIN transceivers.
> +	  This device driver is using CAN_LIN for a userland connection on
> +	  one side and the kernel its serial device bus (serdev) interface
> +	  on the other side.
> +
> +	  If you have a hexLINSER tty adapter, say Y here and see
> +	  <https://hexdev.de/hexlin#hexLINSER>.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called hex-linser.ko.
> +
>  config CAN_SLCAN
>  	tristate "Serial / USB serial CAN Adaptors (slcan)"
>  	depends on TTY
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 0093ee9219ca8..9fdad4a0fd12a 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
>  obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
>  obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
>  obj-$(CONFIG_CAN_LIN)		+= lin.o
> +obj-$(CONFIG_CAN_LIN_HEXLINSER)	+= hex-linser.o
>  obj-$(CONFIG_CAN_MSCAN)		+= mscan/
>  obj-$(CONFIG_CAN_M_CAN)		+= m_can/
>  obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
> diff --git a/drivers/net/can/hex-linser.c b/drivers/net/can/hex-linser.c
> new file mode 100644
> index 0000000000000..9c2d11d2ed0c0
> --- /dev/null
> +++ b/drivers/net/can/hex-linser.c
> @@ -0,0 +1,505 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <net/lin.h>
> +
> +#define LINSER_SAMPLES_PER_CHAR		10
> +#define LINSER_TX_BUFFER_SIZE		11
> +#define LINSER_RX_FIFO_SIZE		256
> +#define LINSER_PARSE_BUFFER		24
> +
> +struct linser_rx {
> +	u8 data;
> +	u8 flag;
> +};
> +
> +enum linser_rx_status {
> +	NEED_MORE = -1,
> +	MODE_OK = 0,
> +	NEED_FORCE,
> +};
> +
> +struct linser_priv {
> +	struct lin_device *lin_dev;
> +	struct serdev_device *serdev;
> +	DECLARE_KFIFO_PTR(rx_fifo, struct linser_rx);
> +	struct delayed_work rx_work;
> +	unsigned long break_usleep_min;
> +	unsigned long break_usleep_max;
> +	unsigned long post_break_usleep_min;
> +	unsigned long post_break_usleep_max;
> +	unsigned long force_timeout_jfs;
> +	struct lin_responder_answer respond_answ[LIN_NUM_IDS];
> +	struct mutex resp_lock; /* protects respond_answ */
> +	bool is_stopped;
> +};
> +
> +static int linser_open(struct lin_device *ldev)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +	int ret;
> +
> +	if (priv->is_stopped) {
> +		ret = serdev_device_open(serdev);
> +		if (ret) {
> +			dev_err(&serdev->dev, "Unable to open device\n");
> +			return ret;
> +		}
> +
> +		serdev_device_set_flow_control(serdev, false);
> +		serdev_device_set_break_detection(serdev, true);
> +
> +		priv->is_stopped = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int linser_stop(struct lin_device *ldev)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +
> +	if (priv->is_stopped)
> +		return 0;
> +
> +	serdev_device_close(serdev);
> +	priv->is_stopped = true;
> +
> +	return 0;
> +}
> +
> +static int linser_send_break(struct linser_priv *priv)
> +{
> +	struct serdev_device *serdev = priv->serdev;
> +	int ret;
> +
> +	ret = serdev_device_break_ctl(serdev, -1);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(priv->break_usleep_min, priv->break_usleep_max);
> +
> +	ret = serdev_device_break_ctl(serdev, 0);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(priv->post_break_usleep_min, priv->post_break_usleep_max);
> +
> +	return 0;
> +}
> +
> +static int linser_ldo_tx(struct lin_device *ldev, const struct lin_frame *lf)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +	u8 pid = LIN_FORM_PID(lf->lin_id);
> +	u8 buf[LINSER_TX_BUFFER_SIZE];
> +	ssize_t written_len, total_len;
> +	u8 checksum;
> +	int ret;
> +
> +	if (lf->len + 3 > LINSER_TX_BUFFER_SIZE) {
> +		dev_err(&serdev->dev, "Frame length %u exceeds buffer size\n", lf->len);
> +		return -EINVAL;
> +	}
> +
> +	buf[0] = LIN_SYNC_BYTE;
> +	buf[1] = pid;
> +	total_len = 2;
> +
> +	if (lf->len) {
> +		memcpy(&buf[2], lf->data, lf->len);
> +		checksum = lin_get_checksum(pid, lf->len, lf->data,
> +					    lf->checksum_mode);
> +		buf[lf->len + 2] = checksum;
> +		total_len += lf->len + 1;
> +	}
> +
> +	ret = linser_send_break(priv);
> +	if (ret)
> +		return ret;
> +
> +	written_len = serdev_device_write(serdev, buf, total_len, 0);
> +	if (written_len < total_len)
> +		return written_len < 0 ? (int)written_len : -EIO;
> +
> +	dev_dbg(&serdev->dev, "sent out: %*ph\n", (int)total_len, buf);
> +
> +	serdev_device_wait_until_sent(serdev, 0);
> +
> +	return 0;
> +}
> +
> +static int linser_derive_timings(struct linser_priv *priv, u16 bitrate)
> +{
> +	unsigned long break_baud = (bitrate * 2) / 3;
> +	struct serdev_device *serdev = priv->serdev;
> +	unsigned long timeout_us;
> +
> +	if (bitrate < LIN_MIN_BAUDRATE || bitrate > LIN_MAX_BAUDRATE) {
> +		dev_err(&serdev->dev, "Bitrate %u out of bounds (%u to %u)\n",
> +			bitrate, LIN_MIN_BAUDRATE, LIN_MAX_BAUDRATE);
> +		return -EINVAL;
> +	}
> +
> +	priv->break_usleep_min = (USEC_PER_SEC * LINSER_SAMPLES_PER_CHAR) /
> +				 break_baud;
> +	priv->break_usleep_max = priv->break_usleep_min + 50;
> +	priv->post_break_usleep_min = USEC_PER_SEC / break_baud;
> +	priv->post_break_usleep_max = priv->post_break_usleep_min + 30;
> +
> +	timeout_us = DIV_ROUND_CLOSEST(USEC_PER_SEC * 256, bitrate);
> +	priv->force_timeout_jfs = usecs_to_jiffies(timeout_us);
> +
> +	return 0;
> +}
> +
> +static int linser_update_bitrate(struct lin_device *ldev, u16 bitrate)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +	unsigned int speed;
> +	int ret;
> +
> +	ret = linser_open(ldev);
> +	if (ret)
> +		return ret;
> +
> +	speed = serdev_device_set_baudrate(serdev, bitrate);
> +	if (!bitrate || speed != bitrate)
> +		return -EINVAL;
> +
> +	ret = linser_derive_timings(priv, bitrate);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int linser_get_responder_answer(struct lin_device *ldev, u8 id,
> +				       struct lin_responder_answer *answ)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +	struct lin_responder_answer *r = &priv->respond_answ[id];
> +
> +	if (!answ)
> +		return -EINVAL;
> +
> +	guard(mutex)(&priv->resp_lock);
> +	memcpy(answ, r, sizeof(*answ));
> +
> +	return 0;
> +}
> +
> +static int linser_update_resp_answer(struct lin_device *ldev,
> +				     const struct lin_responder_answer *answ)
> +{
> +	struct serdev_device *serdev = to_serdev_device(ldev->dev);
> +	struct linser_priv *priv = serdev_device_get_drvdata(serdev);
> +	struct lin_responder_answer *r = &priv->respond_answ[answ->lf.lin_id];
> +
> +	if (!answ)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->resp_lock);
> +	memcpy(r, answ, sizeof(*answ));
> +	r->lf.checksum = lin_get_checksum(LIN_FORM_PID(answ->lf.lin_id),
> +					  answ->lf.len,
> +					  answ->lf.data,
> +					  answ->lf.checksum_mode);

Can this checksum occur outside of lock using the copy in r?

In anycase, use guard() (or scoped_guard() if the checksum can happen 
outside of the lock.)

> +	mutex_unlock(&priv->resp_lock);
> +
> +	return 0;
> +}
> +
> +static struct lin_device_ops linser_lindev_ops = {
> +	.ldo_open = linser_open,
> +	.ldo_stop = linser_stop,
> +	.ldo_tx = linser_ldo_tx,
> +	.update_bitrate = linser_update_bitrate,
> +	.get_responder_answer = linser_get_responder_answer,
> +	.update_responder_answer = linser_update_resp_answer,
> +};
> +
> +static bool linser_tx_frame_as_responder(struct linser_priv *priv, u8 id)
> +{
> +	struct lin_responder_answer *answ = &priv->respond_answ[id];
> +	struct serdev_device *serdev = priv->serdev;
> +	u8 buf[LINSER_TX_BUFFER_SIZE];
> +	u8 checksum, count, n;
> +	ssize_t write_len;
> +
> +	scoped_guard(mutex, &priv->resp_lock) {
> +		if (!answ->is_active)
> +			return false;
> +
> +		if (answ->is_event_frame) {
> +			struct lin_responder_answer *e_answ;
> +
> +			e_answ = &priv->respond_answ[answ->event_associated_id];
> +			n = min(e_answ->lf.len, LIN_MAX_DLEN);
> +
> +			if (memcmp(answ->lf.data, e_answ->lf.data, n) == 0)
> +				return false;
> +
> +			memcpy(answ->lf.data, e_answ->lf.data, n);
> +			checksum = lin_get_checksum(LIN_FORM_PID(answ->lf.lin_id),
> +						    n, e_answ->lf.data,
> +						    answ->lf.checksum_mode);
> +			answ = e_answ;
> +		} else {
> +			checksum = answ->lf.checksum;
> +		}
> +
> +		count = min(answ->lf.len, LIN_MAX_DLEN);
> +		memcpy(&buf[0], answ->lf.data, count);
> +		buf[count] = checksum;
> +	}
> +
> +	write_len = serdev_device_write(serdev, buf, count + 1, 0);
> +	if (write_len < count + 1)
> +		return false;
> +
> +	serdev_device_wait_until_sent(serdev, 0);
> +
> +	return true;
> +}
> +
> +static void linser_pop_fifo(struct linser_priv *priv, size_t n)
> +{
> +	for (size_t i = 0; i < n; i++)
> +		kfifo_skip(&priv->rx_fifo);
> +}
> +
> +static int linser_fill_frame(struct linser_priv *priv, struct lin_frame *lf)
> +{
> +	struct serdev_device *serdev = priv->serdev;
> +	struct linser_rx buf[LINSER_PARSE_BUFFER];
> +	unsigned int count, i, brk = 0;
> +
> +	count = kfifo_out_peek(&priv->rx_fifo, buf, LINSER_PARSE_BUFFER);
> +
> +	memset(lf, 0, sizeof(*lf));
> +
> +	for (i = 0; i < count; i++) {
> +		dev_dbg(&serdev->dev, "buf[%d]: data=%02x, flag=%02x\n",
> +			i, buf[i].data, buf[i].flag);
> +	}
> +
> +	if (count < 3)
> +		return NEED_MORE;
> +
> +	if (buf[0].flag != TTY_BREAK || buf[1].data != LIN_SYNC_BYTE) {
> +		linser_pop_fifo(priv, 1); /* pop incorrect start */
> +		return NEED_MORE;
> +	} else if (!LIN_CHECK_PID(buf[2].data)) {
> +		linser_pop_fifo(priv, 3); /* pop incorrect header */
> +		return NEED_MORE;
> +	}
> +
> +	lf->lin_id = LIN_GET_ID(buf[2].data);
> +
> +	/* from here on we do have a correct LIN header */
> +
> +	if (count == 3)
> +		return linser_tx_frame_as_responder(priv, lf->lin_id) ?
> +		       NEED_MORE : NEED_FORCE;
> +
> +	for (i = 3; i < count && i < LINSER_PARSE_BUFFER && i < 12; i++) {
> +		if (buf[i].flag == TTY_BREAK) {
> +			brk = i;
> +			break;
> +		}
> +		lf->len++;
> +	}
> +	if (lf->len)
> +		lf->len -= 1; /* account for checksum */
> +
> +	if (brk == 3)
> +		return MODE_OK;
> +
> +	if (brk == 4) {
> +		/* suppress wrong answer data-byte in between PID and break
> +		 * because checksum is missing
> +		 */
> +		return MODE_OK;
> +	}
> +
> +	for (i = 0; i < lf->len; i++)
> +		lf->data[i] = buf[3 + i].data;
> +	lf->checksum = buf[2 + lf->len + 1].data;
> +	mutex_lock(&priv->resp_lock);
> +	lf->checksum_mode = priv->respond_answ[lf->lin_id].lf.checksum_mode;
> +	mutex_unlock(&priv->resp_lock);
> +
> +	dev_dbg(&serdev->dev, "brk:%i, len:%u, data:%*ph, checksum:%x (%s)\n",
> +		brk, lf->len, lf->len, lf->data, lf->checksum,
> +		lf->checksum_mode ? "enhanced" : "classic");
> +
> +	if (brk > 4)
> +		return MODE_OK;	/* frame in between two breaks: so complete */
> +
> +	if (lf->len == 8)
> +		return MODE_OK;
> +
> +	return NEED_FORCE;
> +}
> +
> +static int linser_process_frame(struct linser_priv *priv, bool force)
> +{
> +	struct serdev_device *serdev = priv->serdev;
> +	struct lin_frame lf;
> +	size_t bytes_to_pop;
> +	int ret = NEED_MORE;
> +
> +	while (kfifo_len(&priv->rx_fifo) >= LIN_HEADER_SIZE) {
> +		ret = linser_fill_frame(priv, &lf);
> +
> +		if (!(ret == MODE_OK || (ret == NEED_FORCE && force)))
> +			return ret;
> +
> +		dev_dbg(&serdev->dev, "lin_rx: %s\n", force ?
> +			"force" : "normal");

Put to one line.

> +		lin_rx(priv->lin_dev, &lf);
> +		bytes_to_pop = LIN_HEADER_SIZE + lf.len + (lf.len ? 1 : 0);
> +		linser_pop_fifo(priv, bytes_to_pop);
> +		force = false;
> +		ret = MODE_OK;
> +	}
> +
> +	return ret;
> +}


-- 
 i.


