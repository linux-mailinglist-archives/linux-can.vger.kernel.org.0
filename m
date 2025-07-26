Return-Path: <linux-can+bounces-4184-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68434B12C7B
	for <lists+linux-can@lfdr.de>; Sat, 26 Jul 2025 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3431C20B1B
	for <lists+linux-can@lfdr.de>; Sat, 26 Jul 2025 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410A28A1D6;
	Sat, 26 Jul 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOHLnQG5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FB245014;
	Sat, 26 Jul 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563206; cv=none; b=OQkusDEskJLGEIMf/m2Zln9+lULGwLbLZSIoRDhcYzg7iaLalLieVhZrUhLvhpZPQ1uOAGuBlr6LKXmJIPuyOwb3RybWdwFYEDjXq1wVFGqVrcZJ83KbxPoNlharDISrrO+xQgS2lRMb8bVOgoFDtuComWHeS9yX0kApdzu+KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563206; c=relaxed/simple;
	bh=mATAnq34NaRABZoa0/kZTghg/veJQ7qNh/I39utHaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpIRgguU1do5HMrBL0efxQY2LCamqO8P+qQqDmFh+4UAmlBBDXu68UA6EAkpzsJzyNgehcz7owjRhmZGb2mj8JBM87V2e95DZsgCs509oxGLhjNkkHAzSevbvyB6rAYwxM5B1XJc+yERn5XBBXB0gEL0O5Wq+ZuzU4jHuwLviAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOHLnQG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E787C4CEED;
	Sat, 26 Jul 2025 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753563206;
	bh=mATAnq34NaRABZoa0/kZTghg/veJQ7qNh/I39utHaZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOHLnQG5Yv4HeApXvsuW+96Ea2LVo3kCjERazTMKSD+WDrhIDdcXEvZPoynUQ/8Lm
	 CfaiXGIP50zE6B2wKFLSJsKZGx0UeV7Po5lxuwoqtpnsKL63SzDugbUxS1zzZhVDhc
	 KcIsas4Ah1D4Mj89gTkoADtTkBqsfRqy1rRk7V4qvQheVP/sL21J3o4iaXwNS1vLbg
	 3EKVNQTrr5Q/mvjErOsy+IDNcCHhISBLPWjR8QFgIWDjxZsMGD2w2BTPvY7kyBJLG+
	 zkjdjc6rH9umzxfZqJq6S13plVicrmtTHIzK2asJrmHOC+2nbdB57HC91CU8fJiiD3
	 qqJV1WgZEBhOw==
Date: Sat, 26 Jul 2025 21:53:23 +0100
From: Simon Horman <horms@kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/11] can: kvaser_usb: Simplify identification of
 physical CAN interfaces
Message-ID: <20250726205323.GV1367887@horms.kernel.org>
References: <20250725123452.41-1-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>

On Fri, Jul 25, 2025 at 02:34:41PM +0200, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser USB based CAN interfaces.
> 
> Note that this patch series is based on [1]
> "can: kvaser_pciefd: Simplify identification of physical CAN interfaces"
> 
> Changes in v3:
>   - Fix GCC compiler array warning (-Warray-bounds)
>   - Fix transient Sparse warning

FTR, I confirmed that these warnings no longer appear with this version.
Thanks for the updates.

...

