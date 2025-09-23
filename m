Return-Path: <linux-can+bounces-4824-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEEB93AB9
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 02:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51A21613FF
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D632CCC0;
	Tue, 23 Sep 2025 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaZ0zq87"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F254C92;
	Tue, 23 Sep 2025 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586589; cv=none; b=DKQO9ODkuoDByANOVANmIOOccOtlEKR+eLOrIN1jQKfM4PJ3ZKU9c0dTYuC0twZ0AsrhIO6DTnaHmdJ4CMlsFy50WV5t0PJS4SLOk8aGenGQkTYI5aQgXPbTLS/Mjdg6/lRUOrNJ6rS+f5wugBJs4YNjHgVlw3vdLb2mOuyjNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586589; c=relaxed/simple;
	bh=7r23lcbt/GB6hHbqcsy6E8TKdYTvlkPbo1bHULJIOQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O32c7f4NNAG1qzKgPxtEomzfrfa7xh9j6t2PAxwGM4LcJOLsz1QSHOMYecTJ/6eRjVy35xEhMlnkvD6aGReqJtjRdkeGIC5s/9VT4dG4ocYq3QxKrtqzocmf0WuBJkjVCpQKMsOv5odZ/s+aS0UY8EURl3xXZpZRV3+MWsB/d5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaZ0zq87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A5CC4CEF0;
	Tue, 23 Sep 2025 00:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586588;
	bh=7r23lcbt/GB6hHbqcsy6E8TKdYTvlkPbo1bHULJIOQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EaZ0zq874+HFB7Q/IX4aCZRq/xRyUAxWmff6Anu0ba1vvJ2w9PXGRsHZDkvIlcHOO
	 5lBODz1iCcIwitu7IW1trlgJXIS7Mv/2TwmOox8btqxUd7UFiQSE4c09hwUL9uaYog
	 Lzt2xXe9w5Fy0PWs5CfUut+D753+3Sz7YeWZOcEfB5JyJJtXZDSkcsipn4dn7sTr/Z
	 VI04AZKXZQpTSQQvZYGITJYoZDLZ1MgnA9fQ8SUOg+1RYGVsdOxidYIzwxTB1NBL5j
	 FzyZi8rkew/yLRN7zxi6Wn9e5c9l0WXLFCJt04CJux8m1SpoILNpnEg6VKi/uZU9M5
	 dAz7cnhZcBuuA==
Date: Mon, 22 Sep 2025 17:16:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Subject: Re: [PATCH net 08/10] can: esd_usb: Fix not detecting version reply
 in probe routine
Message-ID: <20250922171626.2ebb1e30@kernel.org>
In-Reply-To: <20250922100913.392916-9-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
	<20250922100913.392916-9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 12:07:38 +0200 Marc Kleine-Budde wrote:
> +	do {
> +		int actual_length;
> +		int pos;
> +
> +		err = usb_bulk_msg(dev->udev,
> +				   usb_rcvbulkpipe(dev->udev, 1),
> +				   rx_buf,
> +				   ESD_USB_RX_BUFFER_SIZE,
> +				   &actual_length,
> +				   ESD_USB_DRAIN_TIMEOUT_MS);
> +		dev_dbg(&dev->udev->dev, "AT %d, LEN %d, ERR %d\n", attempt, actual_length, err);
> +		++attempt;
> +		if (err)
> +			goto bail;
> +		if (actual_length == 0)
> +			continue;

continue in do-while loops doesn't check the condition.
This looks like a potential infinite loop?

