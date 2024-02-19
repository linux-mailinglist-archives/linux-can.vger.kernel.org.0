Return-Path: <linux-can+bounces-300-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472AA859E8E
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BC12823CB
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEE20DED;
	Mon, 19 Feb 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNqvrvzI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3721360;
	Mon, 19 Feb 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331954; cv=none; b=o/eiWrsTwX3ZZue1swupKou/WUNnH7MfenkSjuhWuEPix/6yhPM9Ynn/GFd18bc162Q9bSNUjbXd0dLc+nHEBUelFVmojJDS2N7A+xI7k5hzkIgjhI3//fseQssfl9KT6LH304kE3xwYyWncJOZ2twaKgQYLbaz6oB97j/1FU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331954; c=relaxed/simple;
	bh=F+mNwb1v5ArOUUf7Ps13F1Wfz6iafQN1LGLh3Kt4g/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtq/BTRYjMnAT/En6rZOfgb0araFilnGWzScuSMgcgRI/ZtzKR1TqyEsF+IGAIlL1FtLdgZcLTl9PKCdJ2Rcyhd/OwDD7Isbyin+cutwm1zFXtgjdG3R+MtEUTgKaygwVXfu9b7N0ii5pUZo5yeQwdZDDGO15SKfJHFf8izpqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNqvrvzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E7CC433C7;
	Mon, 19 Feb 2024 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708331954;
	bh=F+mNwb1v5ArOUUf7Ps13F1Wfz6iafQN1LGLh3Kt4g/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNqvrvzIA2uxnzVCcWrEXcvSlOrujBjUKPrIPKjFpyjzoyubZdUDf/qg5JI/LptPD
	 w2uCHGBtZSxvl48ALEUeaierYSxPFgg1UwKegtyEjAqEvvNp9FigwDNSeVaxtKI4hX
	 9fz6/xMjk46yZAqfyPeEdhfdfCPywpQH1yrCiCzIg07lCPRLdOyhhKagLh3SwMg15q
	 dzFdFI87wWEiD0widMBF1Pk3+Cr+4zhqcArzIZgBpZgJ/YSglF/KHu1Sqj3iLKJVjf
	 mtBP3DyY5q77ZSNO6qWsEqZs8WpPuV2r5boc7Yjx3+2GIhWVaESKEiK4UppuZJLJpI
	 x2so/oh1EYTyQ==
Date: Mon, 19 Feb 2024 08:39:10 +0000
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-can@vger.kernel.org, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 22/23] can: canxl: add virtual CAN network
 identifier support
Message-ID: <20240219083910.GR40273@kernel.org>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-23-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213113437.1884372-23-mkl@pengutronix.de>

+Dan Carpenter

On Tue, Feb 13, 2024 at 12:25:25PM +0100, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> CAN XL data frames contain an 8-bit virtual CAN network identifier (VCID).
> A VCID value of zero represents an 'untagged' CAN XL frame.
> 
> To receive and send these optional VCIDs via CAN_RAW sockets a new socket
> option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:
> 
> - tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
> - tx: pass through VCID values from the user space (e.g. for traffic replay)
> - rx: apply VCID receive filter (value/mask) to be passed to the user space
> 
> With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
> values can be sent, e.g. to replay full qualified CAN XL traffic.
> 
> The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> override the VCID value in the struct canxl_frame.prio defined for
> CAN_RAW_XL_VCID_TX_PASS when both flags are set.
> 
> With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
> passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
> Without this flag only untagged CAN XL frames (VCID = 0x00) are delivered
> to the user space (default).
> 
> The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
> frames!) to not interfere with other CAN content or the CAN filters
> provided by the CAN_RAW sockets and kernel infrastruture.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://lore.kernel.org/all/20240212213550.18516-1-socketcan@hartkopp.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Oliver and Marc,

I understand this pull-request has been accepted.
But I noticed the problem described below which
seems worth bringing to your attention.

...

> @@ -786,6 +822,21 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>  		val = &ro->xl_frames;
>  		break;
>  
> +	case CAN_RAW_XL_VCID_OPTS:
> +		/* user space buffer to small for VCID opts? */
> +		if (len < sizeof(ro->raw_vcid_opts)) {
> +			/* return -ERANGE and needed space in optlen */
> +			err = -ERANGE;
> +			if (put_user(sizeof(ro->raw_vcid_opts), optlen))
> +				err = -EFAULT;
> +		} else {
> +			if (len > sizeof(ro->raw_vcid_opts))
> +				len = sizeof(ro->raw_vcid_opts);
> +			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
> +				err = -EFAULT;
> +		}
> +		break;
> +
>  	case CAN_RAW_JOIN_FILTERS:
>  		if (len > sizeof(int))
>  			len = sizeof(int);

At the end of the switch statement the following code is present:


	if (put_user(len, optlen))
		return -EFAULT;
	if (copy_to_user(optval, val, len))
		return -EFAULT;
	return 0;

And the call to copy_to_user() depends on val being set.

It appears that for all other cases handled by the switch statement,
either val is set or the function returns. But neither is the
case for CAN_RAW_XL_VCID_OPTS which seems to mean that val may be used
uninitialised.

Flagged by Smatch.

...

