Return-Path: <linux-can+bounces-1650-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2F99BDF3
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 05:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F4DB21CC4
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CD2B2DA;
	Mon, 14 Oct 2024 03:04:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA5196;
	Mon, 14 Oct 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875046; cv=none; b=a/dTDeBjvdhWXL8PHohb6BgEDplJS4SbZSi1S9xAwEkJK72gDLNJZFbgzifb58WauvOv6ok1bqI1rESbGiqubdnrNRTU1qPQEPvMXu+WpzV2lrydL4E4ZrnSVigQtydhnNTAPsu/tYlXqdNt0292dkzWR84VyL2SJSZ9sGu5338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875046; c=relaxed/simple;
	bh=wi//xKA17vRkcbTb40CDhI5yUW/c0y31lrn/7YX8/Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jidrrh0X75Ya0S5WKfLGIuG4JZY708doPyWFJX+Tc7oKNAal6GDAAnU+LkC9nIPFLw93WIgsLaOSmNJ8R4yI0/a4wVi+pQh0wkFg1E2wmX6321rXFOqueOVSDOwoV7eQ+xNroF6uB8x+3ltcH+gviFhp8fiewt1NuVCgsDEO4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso72507566b.1;
        Sun, 13 Oct 2024 20:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875042; x=1729479842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi//xKA17vRkcbTb40CDhI5yUW/c0y31lrn/7YX8/Ys=;
        b=dmyfYtCU1dhNC5L0OT9a2cpT5ZrsqlxxA7T4DDQUCXREetaDYpO6VFBreMWueUiHuG
         E63kv/88zXMqnKXw41KAdBVLIVn+QMeuXrDw9Hc5Ji6micRswSkfTSLKyj6naO/DylO7
         YVWj5maurl7uHXY7s1pPaRh8ZMORhLiVnKjdb+Nd8xkCshngEe88KaC67KWYtuBzVJGQ
         iqDrcBQKDPHOJVQbdF0gYhG6de5RaCl22WGuTePHBmyU9YCn6rlv3N5BKeODUt4G7bSg
         wiKKqvXif6+e2aMCRg5vemK4NfRzkolxzW0UxzQxHpZmrJcHxjMJ/nAHnwoF2BQv9eLX
         7c7w==
X-Forwarded-Encrypted: i=1; AJvYcCUbW0pjVYzq4/ipE8SbdvMMtNQ7fCBblWtQiJFTffyzXAu2H/UvYRDkKrjTyQHF9hzJhxqmrPRr@vger.kernel.org, AJvYcCUqnxA7WW/p7DQuJzf+LiEqs1sJLWifDe5eyiRTUCwjPVROpvO5G2cvQZwgoKlW7K9g3mezcJ+awJEvG2/dMv0=@vger.kernel.org, AJvYcCX2yXFKcJYSS5ObWPXKWm2QH9BuFf1LJ1QeKqdS3+d1PVuLO8SUAyQlQA75KgxWGiDpd+a6dLBSfAJG@vger.kernel.org, AJvYcCXZIB9VxP74OBl1EW7bgXzWsWmOD5MSlEmyDawl3DkDCj8hwEDsnJiCN7oyWJhvlf5bJtgCQfaQJ0tGQ/15@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vbP85qbKacFkQ4TXfjcJGWDiR+tiwK1Mx9CasZix9GsFJ+I1
	joIzhyMFs4sbpFcDYnK+TZhDp4vu+xmaQ2c1eEfP6K4XG6BpIhx1e6R1g2/C49CKMzbiql2xN/a
	L0YOhIco/wM8rITA18aWz+hnkc8Y=
X-Google-Smtp-Source: AGHT+IFNiMGbY/5Zo805pZfKtRSxuh/9OJ5e3DgonSSpqNK1J1+bOAyc8dhhBwU4LB+KnrEKnjMkRHHeVnQRBcJhBGw=
X-Received: by 2002:a17:907:3e23:b0:a99:43e1:21ad with SMTP id
 a640c23a62f3a-a99b9585822mr939308266b.45.1728875042463; Sun, 13 Oct 2024
 20:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-11-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-11-Julia.Lawall@inria.fr>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 14 Oct 2024 12:03:51 +0900
Message-ID: <CAMZ6RqL2+srRF15spoLqXhe40w02TEDpAzb+gnbVgD-os-f87Q@mail.gmail.com>
Subject: Re: [PATCH 10/17] can: gw: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	"Paul E . McKenney" <paulmck@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-can <linux-can@vger.kernel.org>, netdev <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Julia,

Thanks for the patch.

On Mon. 14 Oct. 2024, 05:21, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

