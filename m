Return-Path: <linux-can+bounces-2725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C8A273B1
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05341888A6C
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716D6212FB4;
	Tue,  4 Feb 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZpMs3J0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D823211A38;
	Tue,  4 Feb 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676733; cv=none; b=GOwpXta8CIwWMQoULK1mYyJz3+DpLGJEDfLFHrJeGdmjwdsRq7cKd/88XUsnyZJC+6Gn9aNn/piajYn6TRpI5ng9MkLFYUVLiqbLatwl8PMj6v2YDG6JoR0Ryj70qAbTAfcTxM/Wj79n0XTvaV/vJ349mtF4qbE37tJJqIXXD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676733; c=relaxed/simple;
	bh=d0lrcRneNPYnFy4fVXFs02h42lMTK8IUJg6ExdNXu/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/5QGF1zFZ/nfKfyX8un1LqsLDRXgcpVq3Cizhi30iAvIJ928FkTrIdGaLPCFie4XjczzaKVheYIaHMmcTa9cKcOu2IjJ+99De5xISohp/tP1AzN3oDuDBPQ6SfuvejVYgg6QwDPCvNKMSXxBia89Um2qhoXP44op6wQOQ/+nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZpMs3J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0B8C4CEE4;
	Tue,  4 Feb 2025 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738676732;
	bh=d0lrcRneNPYnFy4fVXFs02h42lMTK8IUJg6ExdNXu/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZpMs3J0f+l0bK+EgdXM34laO/O2rEUVkfenJjEwUkpmyhQAHOyF5qv2JDM75zcs2
	 nkTnyJ28rPnhqo5U5R5l1Bu1BCaejBqz4NgF6HeOE2kXzkmD+pyOW1YMcqRIvOLe5L
	 Co32d6CHTq6HDlLGp3gPVnFthGIImy50rmtfXwZrkf6pbNq9s5e3oo284fPJCXtWKc
	 lZ8rSwD08xh3KrfF6SFn0APK1X39BgVSo7cghaS7fo0oJ7sJlu7SpkgD73VPjxWjPS
	 CRPfbkuLIEoLwOXuA8Q2lGzn1wP54d8WZ3fw/COgUKPZozDYqu3wHpNQs8lAIVjkAM
	 MVqqYDS+UQgsA==
Date: Tue, 4 Feb 2025 13:45:27 +0000
From: Simon Horman <horms@kernel.org>
To: Reyders Morales <reyders1@gmail.com>
Cc: kuba@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/networking: Fix basic node example
 document ISO 15765-2
Message-ID: <20250204134527.GD234677@kernel.org>
References: <20250203224720.42530-1-reyders1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203224720.42530-1-reyders1@gmail.com>

On Mon, Feb 03, 2025 at 11:47:20PM +0100, Reyders Morales wrote:
> In the current struct sockaddr_can tp is member of can_addr.
> tp is not member of struct sockaddr_can.
> 
> Signed-off-by: Reyders Morales <reyders1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


