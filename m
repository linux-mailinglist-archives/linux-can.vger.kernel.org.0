Return-Path: <linux-can+bounces-1571-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19C987FD5
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6911C231B0
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609317836E;
	Fri, 27 Sep 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrzc6Htw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5416EBE6;
	Fri, 27 Sep 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423872; cv=none; b=ZlTw1g9bJ4Ndg7xITLOSC447rpJxCuN7e/BxJ16pMYUb8Y9m4sJ6D0sVVeJckhIrilEI3XGs5ygtWvIr9EEjWrbgXb2td7uLy1lRPxZ0SI2QtuOSEe54DIpp7pbrsY8DDo8iG9fO7iMLnzA2U0Q0i47/LmXi10t4dQD52wjA0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423872; c=relaxed/simple;
	bh=ZmTaF4/jc03LTIvMK0BOhpgNc6JKRjuItosjrR7N3zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhAQGexqpHzf3ZWvm6v5mMidDcJwFbgYDN0JfdgHuWe6fg7fA47iehnUaP/qerufwUoNeHCLElUGgnQHTb2NFNPRAq8FwJse+bLCtRSAx6dOO+Pviog6+W17EmzlxXs6yMn8po9lOWYEgkE8pkFc2fqqMMLVpLW7hnWt4SMsh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrzc6Htw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4C9C4CEC4;
	Fri, 27 Sep 2024 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727423871;
	bh=ZmTaF4/jc03LTIvMK0BOhpgNc6JKRjuItosjrR7N3zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrzc6HtwoxrZp3+CTD1k/ZQH5Squr3u9UdkSdbuLxkHv0kL97t6VI2FCXfU3BwHI9
	 VzM96Uv/Gbv8pwFi9yU53Tb+6fWnBThohI5dFuUZAr0hBy6x7wS3/KLOw+hsUrPLFN
	 HobEEquZCwwCvFOCu245OWhw165FcK6El8IsoYWo=
Date: Fri, 27 Sep 2024 09:57:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
	kernel@pengutronix.de
Subject: Re: mcp251xfd: please add to the stable trees
Message-ID: <2024092734-tackle-outlying-ae73@gregkh>
References: <20240924-truthful-authentic-basilisk-aaab90-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-truthful-authentic-basilisk-aaab90-mkl@pengutronix.de>

On Tue, Sep 24, 2024 at 08:51:00AM +0200, Marc Kleine-Budde wrote:
> Hello stable-team,
> 
> Francesco Dolcini reported a regression on v6.6.52 [1], it turns out
> since v6.6.51~34 a.k.a. 5ea24ddc26a7 ("can: mcp251xfd: rx: add
> workaround for erratum DS80000789E 6 of mcp2518fd") the mcp25xfd driver
> is broken.
> 
> Cherry picking the following commits fixes the problem:
> 
> 51b2a7216122 ("can: mcp251xfd: properly indent labels")
> a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()")
> 
> Please pick these patches for
> 
> - 6.10.x
> - 6.6.x
> - 6.1.x
> 
> [1] https://lore.kernel.org/all/20240923115310.GA138774@francesco-nb

Now queued up, thanks

greg k-h

