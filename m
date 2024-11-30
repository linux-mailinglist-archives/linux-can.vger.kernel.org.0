Return-Path: <linux-can+bounces-2289-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC79DF386
	for <lists+linux-can@lfdr.de>; Sat, 30 Nov 2024 23:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E3D280A1E
	for <lists+linux-can@lfdr.de>; Sat, 30 Nov 2024 22:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15241AA1DE;
	Sat, 30 Nov 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiU/3cGP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27117BD3;
	Sat, 30 Nov 2024 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005460; cv=none; b=Q7UqC9vyBP+BFcE16OdgqfZ/idnpw1HcGfE12qBITN0K0PmFQaTCzGTQcErpRntb+iWnqsRhLufTt/bKdYOWf/xievhhbTS1jo6olWl+KoS3I/x2youdEu/e+T8PDH0eJBqMrZ3dfAE+hewhEpFIyj2yTOBZAK39ywzqU+BMQcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005460; c=relaxed/simple;
	bh=CtM5hOgaiOMLF2wA4W4wZjv192MP7mz4BOIB5kBZ8GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEfWjqKTMlAsFYTYtdWjXxtDFcl7coHLC+U97Ii8axqgtVxoaoJUg/v5ODdfdVHvKGKuGikfoY1mmQ5IT3DJdOnxLI7EXaw2tgnHnRsB7I9AOgdC57LvTCyFHxX9yXh2yujdl3d4GvzmIkXOXhLvaeKsa8XVij5XwoUHRlxH1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiU/3cGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F7CC4CECC;
	Sat, 30 Nov 2024 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733005458;
	bh=CtM5hOgaiOMLF2wA4W4wZjv192MP7mz4BOIB5kBZ8GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JiU/3cGPZiRrVXY802/N3juOgbckzY7TQuICeKIQFhQ3ztL/FV57NgRoqdM5nuPCx
	 QgQxa9RfjGzIM1edqmI/b/CjYKc2MMT8xZgZUDkKccaY4wuo+JU7JI5Q4DFof37LUZ
	 DriBoWkx0LURi5NXbJ6dSafTyNIdFbWfZuotm5ERAG3zdvGPISuGoBwVHiCcQfJq/Y
	 fuYXUGSf5IskbSa7RccC6+lXXgT30h+W1T4hYKxn83a98L7YL9Ls7Mws2sXsYAvoHK
	 C1qobCz841iy4XhasTBkiNrNbKkTH01UL97cP1xgVYrT0T4fHfEZj/MRvAf+QtSHQa
	 VdhqmuY0ivaGg==
Date: Sat, 30 Nov 2024 14:24:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/14] pull-request: can 2024-11-29
Message-ID: <20241130142416.66e2caa2@kernel.org>
In-Reply-To: <20241129122722.1046050-1-mkl@pengutronix.de>
References: <20241129122722.1046050-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 13:16:47 +0100 Marc Kleine-Budde wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.12-20241104

Looks like the tag here is stale?

