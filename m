Return-Path: <linux-can+bounces-629-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474088C2705
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C0E1C22281
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251C317089C;
	Fri, 10 May 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvXgBHQj"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78914B08C;
	Fri, 10 May 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351969; cv=none; b=TWjeIPYKDWrDPN3SC+MhbQS7FV99CPwfB3CM7yVq0F3PvVno0PgGecHZFuU2go7WXYXXsw9IiHVNjbwKzfPeB18qLQ2x3N22daO6HsxcUfuzCwXuq9RE5M3g+3iva3Q+PLiLLU9khkLPUxZ9CrB7oOfYbLoDu1EVvRaWh+LgejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351969; c=relaxed/simple;
	bh=1mZQpCNgLHeL3u0oeK2XgbI336g5gF4n4i2zz/VMjDM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OLE8PG9JQDp1PtCNlVC31oFKvsdP4KQFk6nmFHzTHWx3stVOvessrHl9J3y9ZgOBm0rsYUSc7u9WE7BzEqKS8iv1Qnwj4qGDJriUDG0SewbqYmEBml5Lf9FLnH7ZRJXWMI1N2nCNV59TbLApbeVt83fIgwFE5HHOBcCrqHw7PtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvXgBHQj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351967; x=1746887967;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1mZQpCNgLHeL3u0oeK2XgbI336g5gF4n4i2zz/VMjDM=;
  b=SvXgBHQjNX2wMKP4lWONzlnSFTJLCH/2xHX8FqcTNZAT2bMcq57W5RJO
   Pc3O6bsEelc00UYinwyX0VwvRCdOG5mTCoNy5QlC3Hdq8zjHm7NhcXPFi
   i8VL7mcYLT3bEPxAVSnFDtS+Vn2mSKRo63NZSj+qtYtbzVvFD+Fd0IMLb
   Ch7TqGyrVAA3Cx9TWgdyKfRBDiNbhvixFswQ7yKwHCt37AEJgGa8uoWxZ
   ag7xehK04+b1oavmd7My5IQOlcQYRBGrgTJ81JmkSlSGxknw2s6QIzeq3
   6FIVVYftIBGdriv2M/beQw88fGYPXxQXcM2KRMVPHqtbRi5Tk5MisojRH
   Q==;
X-CSE-ConnectionGUID: VH9LRxpWTqmMk5oEfLJ9fA==
X-CSE-MsgGUID: 10qs1WjSSCSOscoBysG28w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22006598"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22006598"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:39:26 -0700
X-CSE-ConnectionGUID: VVDy6M/OSrqsiWz0tSC0nA==
X-CSE-MsgGUID: uxmhq12gTaSaAmPHBnqdFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30018377"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:39:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 17:39:14 +0300 (EEST)
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
Subject: Re: [PATCH v4 10/11] can: lin: Support setting LIN mode
In-Reply-To: <20240509171736.2048414-11-christoph.fritz@hexdev.de>
Message-ID: <b796b3ac-df5e-e39a-7ae2-db7b7829abaa@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-11-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Christoph Fritz wrote:

> A LIN node can work as commander or responder, so introduce a new
> control mode (CAN_CTRLMODE_LIN_COMMANDER) for configuration.
> 
> This enables e.g. the userland tool ip from iproute2 to turn on
> commander mode when the device is being brought up.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/net/can/lin.c            | 40 +++++++++++++++++++++++++++++++-
>  include/net/lin.h                |  7 ++++++
>  include/uapi/linux/can/netlink.h |  1 +
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
> index f77abd7d7d21c..03ddf5d5a31b8 100644
> --- a/drivers/net/can/lin.c
> +++ b/drivers/net/can/lin.c
> @@ -262,11 +262,40 @@ static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> +static int lin_update_mode(struct net_device *ndev)
> +{
> +	struct lin_device *ldev = netdev_priv(ndev);
> +	u32 ctrlmode = ldev->can.ctrlmode;
> +	enum lin_mode lm;
> +	int ret = 0;
> +
> +	lm = (ctrlmode & CAN_CTRLMODE_LIN_COMMANDER) ? LINBUS_COMMANDER :
> +						       LINBUS_RESPONDER;
> +	if (ldev->lmode != lm) {
> +		if (!ldev->ldev_ops->update_lin_mode) {
> +			netdev_err(ndev, "setting lin mode unsupported\n");

In user visible messages, it would be best to use the expected 
capitalization, which I suppose is LIN given you use capitals in the 
commit message yourself?

> +			return -EINVAL;
> +		}
> +		ret = ldev->ldev_ops->update_lin_mode(ldev, lm);
> +		if (ret) {
> +			netdev_err(ndev, "Failed to set lin mode: %d\n", ret);

Ditto.

There might be other cases in any of the patches, please check.

> +			return ret;
> +		}
> +		ldev->lmode = lm;
> +	}
> +
> +	return ret;
> +}
> +
>  static int lin_open(struct net_device *ndev)
>  {
>  	struct lin_device *ldev = netdev_priv(ndev);
>  	int ret;
>  
> +	ret = lin_update_mode(ndev);
> +	if (ret)
> +		return ret;
> +
>  	ldev->tx_busy = false;
>  
>  	ret = open_candev(ndev);
> @@ -443,7 +472,7 @@ struct lin_device *register_lin(struct device *dev,
>  	ndev->sysfs_groups[0] = &lin_sysfs_group;
>  	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
>  	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
> -	ldev->can.ctrlmode_supported = 0;
> +	ldev->can.ctrlmode_supported = CAN_CTRLMODE_LIN_COMMANDER;
>  	ldev->can.bitrate_const = lin_bitrate;
>  	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
>  	ldev->can.do_set_bittiming = lin_set_bittiming;
> @@ -458,6 +487,15 @@ struct lin_device *register_lin(struct device *dev,
>  		goto exit_candev;
>  	}
>  
> +	ldev->lmode = LINBUS_RESPONDER;
> +	if (ldev->ldev_ops->update_lin_mode) {
> +		ret = ldev->ldev_ops->update_lin_mode(ldev, ldev->lmode);
> +		if (ret) {
> +			netdev_err(ndev, "updating lin mode failed\n");

Ditto.

> +			goto exit_candev;
> +		}
> +	}
> +
>  	ret = register_candev(ndev);
>  	if (ret)
>  		goto exit_candev;
> diff --git a/include/net/lin.h b/include/net/lin.h
> index 31bb0feefd188..63ac870a0ab6f 100644
> --- a/include/net/lin.h
> +++ b/include/net/lin.h
> @@ -36,6 +36,11 @@ struct lin_attr {
>  	struct lin_device *ldev;
>  };
>  
> +enum lin_mode {
> +	LINBUS_RESPONDER = 0,
> +	LINBUS_COMMANDER,
> +};
> +
>  struct lin_device {
>  	struct can_priv can;  /* must be the first member */
>  	struct net_device *ndev;
> @@ -45,6 +50,7 @@ struct lin_device {
>  	struct work_struct tx_work;
>  	bool tx_busy;
>  	struct sk_buff *tx_skb;
> +	enum lin_mode lmode;
>  };
>  
>  enum lin_checksum_mode {
> @@ -71,6 +77,7 @@ struct lin_device_ops {
>  	int (*ldo_open)(struct lin_device *ldev);
>  	int (*ldo_stop)(struct lin_device *ldev);
>  	int (*ldo_tx)(struct lin_device *ldev, const struct lin_frame *frame);
> +	int (*update_lin_mode)(struct lin_device *ldev, enum lin_mode lm);
>  	int (*update_bitrate)(struct lin_device *ldev, u16 bitrate);
>  	int (*update_responder_answer)(struct lin_device *ldev,
>  				       const struct lin_responder_answer *answ);
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index a37f56d86c5f2..cc390f6444d59 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -104,6 +104,7 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
>  #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
>  #define CAN_CTRLMODE_LIN		BIT(11)	/* LIN bus mode */
> +#define CAN_CTRLMODE_LIN_COMMANDER	BIT(12)	/* LIN bus specific commander mode */
>  
>  /*
>   * CAN device statistics
> 

-- 
 i.


