Return-Path: <linux-can+bounces-6171-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E4D2A5EB
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 03:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D932305B1DE
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE52337B9D;
	Fri, 16 Jan 2026 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZH6GEZu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683631D371;
	Fri, 16 Jan 2026 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531871; cv=none; b=Bl6UsxX3T7InU9eZp3KrKxU4EMnteiIHmA7qKyO4jlRBeWfXMV8wVYqsBIQP0WMV3yd8hw9oYpFhlWcQ/7X6Q5We1bG6y7eW2phTl7eckrcZHXY5KmDM4Ld0Wkhjn1AYxKSQD2unGsLZmB7dNYuyxLXohFuuPsOw6J2oMwSBRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531871; c=relaxed/simple;
	bh=c+ublGeQ2GKZNYsbFMLt62VOVByqn7UxmEQZbcPs/ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0VYtk97/4RvFndJEt9USpjUqEyxHcxfMSBhPc4kvHqNYODbLmGivTuzWtLfaw027d0JbBBQ2R2tDIKu18YriMt/zpB3uEWEYAJN5OL+2yVkKmQUFPaItmmxi2VjHjXJMhS88D7yajiIWZ1se+dPCT+5hjeBABIGNUrhR4G1F2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZH6GEZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF7C116D0;
	Fri, 16 Jan 2026 02:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531871;
	bh=c+ublGeQ2GKZNYsbFMLt62VOVByqn7UxmEQZbcPs/ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZH6GEZuC9kIX7Uu1Pc+zGv7wETXlTqy7vIighXRTBXLf7UgGXBwgFM3s5R35rm1S
	 uEPbyK0MqVOe0hPJdnGkrwkRnLmqW14DGTCjNlHnZzhIx0vr044GPYYwFvFXaOTTfM
	 P4wN0jQm367CVMrrJ9Yag9iiUiHHB7nB8pS2URsNqs8C+XG3sNxcx+7TiolfFgeSa5
	 wZ6VDf3gnCsREeOP0cYNOq74DO7CuEFlGqqu9dK2gfo/9RXCB0piYd2+hp6OxCHShk
	 xO7PRlrKgeT+5eqU4ybyhuDIlNhXYqbPWIusqToPqyMEkyLvtP4XwfD5C94j+Bk7OO
	 MCPHIHdoftf3A==
Date: Thu, 15 Jan 2026 18:51:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
Message-ID: <20260115185110.6c4de645@kernel.org>
In-Reply-To: <20260115090603.1124860-1-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 09:57:07 +0100 Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 4 patches for net/main, it super-seeds the
> "can 2026-01-14" pull request. The dev refcount leak in patch #3 is
> fixed.
> 
> The first 3 patches are by Oliver Hartkopp and revert the approach to
> instantly reject unsupported CAN frames introduced in
> net-next-for-v6.19 and replace it by placing the needed data into the
> CAN specific ml_priv.
> 
> The last patch is by Tetsuo Handa and fixes a J1939 refcount leak for
> j1939_session in session deactivation upon receiving the second RTS.

Hi Marc!

Was the AI wrong here
https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
or that fix is still in the works?

