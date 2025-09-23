Return-Path: <linux-can+bounces-4825-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA1B93AC0
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 02:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2332F164E6A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA93595C;
	Tue, 23 Sep 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZQ6HEzh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92C290F;
	Tue, 23 Sep 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586640; cv=none; b=LgFkBt4Ff4tTjvF9SHRZisDM+M3H9p9n4foANnZcc1g1PQ7dQjkuyGTUb0RVle3AD13Cia0jjH3NC8wS3ummUGJbkgtw1YikSVbt1RGD/rugoVJ1Oc71x8vJVDLWqJJPKkGBUR53Kxt6G1Mm1FvefBY/PZp3caJsfXbmHQ0v0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586640; c=relaxed/simple;
	bh=G+P37aMprvzlqfYycmh/5Smd7Trbh8oFY2WxONZjtzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXBQhK0t09Qkxm2It+9GsMF2hyKy1IhqFtXJkKTlZ/1tvSegAyUnBpWcDT7ukxqvjgfP1CQSDCM/Prch1OcmlNjh00fvmkP6mPMw1zqetQbhm00/brWD3jZgRmExa+PeFKIwYxK0hdiArr2nS5GnNvoPJwLM6nVTvufT7sTlaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZQ6HEzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A2BC4CEF0;
	Tue, 23 Sep 2025 00:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586640;
	bh=G+P37aMprvzlqfYycmh/5Smd7Trbh8oFY2WxONZjtzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZQ6HEzha4BHLh82DcKxyL82n57q9Y7H7Qo0ofVsTN7vDLxg2RRBTkhcjkPoedgLy
	 Hsqdl2z68X6gseN2asO78TKMKWIONHu0656vzSF2YUO7bVsY/gldvC9pMMSMXS16tH
	 ul1G8b8BC3qH8vnowalOokYz8x2lamPGF4w5uaRwEy4Cd1xRkZDzgQhSo+TfQ7TKHy
	 bThocDZfRiBCAAj5KFcVqVKc4Xlp/Jo5Uo25N/Zpfg8Vq4tpTww40/t7YF+HHg5wsv
	 m2pawxNBCnn35up5jArW/9MfK1ZgpXSbpQlV7G9uai7hX3rRKPVfjX6K2FUIGeVrt6
	 5MYdlkLeD5P/g==
Date: Mon, 22 Sep 2025 17:17:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Subject: Re: [PATCH net 09/10] can: esd_usb: Fix handling of TX context
 objects
Message-ID: <20250922171719.0f1bdb28@kernel.org>
In-Reply-To: <20250922100913.392916-10-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
	<20250922100913.392916-10-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 12:07:39 +0200 Marc Kleine-Budde wrote:
> -		netdev_warn(netdev, "couldn't find free context\n");
> +		netdev_warn(netdev, "No free context. Jobs: %d\n",
> +			    atomic_read(&priv->active_tx_jobs));

This should really be rate limited or _once while we touch it.

