Return-Path: <linux-can+bounces-4183-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCEB12C15
	for <lists+linux-can@lfdr.de>; Sat, 26 Jul 2025 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26091686FD
	for <lists+linux-can@lfdr.de>; Sat, 26 Jul 2025 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BE155C97;
	Sat, 26 Jul 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx1SkluW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4662FBF0;
	Sat, 26 Jul 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753559298; cv=none; b=Zl/ZNwa47hT/mtjkixgxa9NyL3Z3gedoynCjPFtJ3MrP2QVXgvtanOWa4Pabc1DwKxHFJKc36MuXgYab0Xo7DuVDVFuhCz6wTVBjNRqIqTOrnbH9iLZazy+RSSwTPsyL2q2MyO+ues+4CVza4uVyL31+ql0Fba9fpPjXbhZSixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753559298; c=relaxed/simple;
	bh=Eu7mCczLCzH4Q++ee3PkwjTBB0+cpzTWGw87b1bP/2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlIyAsLsmCVUDCFs5s7i7b5b1KnqRg42qZaQpdwUZKdl7vM670YB7iKxEBjnogpmmxcYp0eJ8JCz8UVg1oEv6vOfmV4rzuBlzD8gALYzBxxubI1YEoKXZuEwW8rTeLudZ09Mcb3W4gUCb694IycKyukCBXg87WNWz4VxyfqIqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx1SkluW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644EC4CEED;
	Sat, 26 Jul 2025 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753559297;
	bh=Eu7mCczLCzH4Q++ee3PkwjTBB0+cpzTWGw87b1bP/2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fx1SkluWSqFlrJ6xNeC4nmRiNW2A5DeYy4E0nBF0AuaQeKL0eLY9cF3ZNCvQu49a5
	 VQ7Vk9a4CL7NmSflTqBo+07ufSkJlyjEIzmoYwzACM/+YAstceA842zro+d74tHhGl
	 wRRWxlrtdHX8QxM6JFt0rJmQTKeFmFid7eHRgqbVxfSjOpJjVzY+iW0tr4DDkZdYki
	 j9Ou4a5FvgZDoL/3z8qr0koiPRf2SEP/4MFcdKNeuMcY/wo0WhldwokQmboO+4O4j8
	 1gpfBm4+dFaHxOMYSeg7FEZ0kDjSLdJqO8D9WqlY3imCxHzVEadAUfwM1M/zsMy/sv
	 yJY0yEqHIKL2A==
Date: Sat, 26 Jul 2025 20:48:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/11] can: kvaser_usb: Add support to control CAN
 LEDs on device
Message-ID: <20250726194813.GN1367887@horms.kernel.org>
References: <20250724092505.8-1-extja@kvaser.com>
 <20250724092505.8-2-extja@kvaser.com>
 <20250724182611.GC1266901@horms.kernel.org>
 <a07d995f-0fdf-4773-8cc4-4db6f72ce398@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07d995f-0fdf-4773-8cc4-4db6f72ce398@gmail.com>

On Fri, Jul 25, 2025 at 02:44:52PM +0200, Jimmy Assarsson wrote:
> On 7/24/25 8:26 PM, Simon Horman wrote:
> > On Thu, Jul 24, 2025 at 11:24:55AM +0200, Jimmy Assarsson wrote:

...

> > GCC seems to know that:
> > * cmd was allocated sizeof(*cmd) = 32 bytes
> > * struct kvaser_cmd_ext is larger than this (96 bytes)
> > 
> > And it thinks that cmd->header.cmd_no might be CMD_EXTENDED.
> > This is not true, becuae .cmd_no is set to CMD_LED_ACTION_REQ
> > earlier in kvaser_usb_hydra_set_led. But still, GCC produces
> > a big fat warning.
> > 
> > On the one hand we might say this is a shortcoming in GCC,
> > a position I agree with. But on the other hand, we might follow
> > the pattern used elsewhere in this file for similar functions,
> > which seems to make GCC happy, I guess, and it is strictly a guess,
> > because less context is needed for it to analyse things correctly.
> 
> Thanks for finding this!
> 
> Marc Kleine-Budde actually sorted this out for other commands some years ago [1],
> but I had completely forgotten.
> 
> [1] https://lore.kernel.org/all/20221219110104.1073881-1-mkl@pengutronix.de

Nice, thanks for digging that up.

