Return-Path: <linux-can+bounces-1296-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20D968096
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F4A281EEE
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91239176ADE;
	Mon,  2 Sep 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7TIY01H"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A4153BC7
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262191; cv=none; b=s8M4kqdGocWeQG57UfV31sbQmOLV41ABqRn1qDyArRoBNIyV3c+HYmQBTfm9tG3OpmwC+K03YxfCw4CHxw/bzhjTyZ2DpHsAProWNWqd0eFuf7P9X33jnTfzjRolEdGGTuy8qK7pElIMU+A40Wre+ruXIQCAR94Baz2oYtAVBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262191; c=relaxed/simple;
	bh=mTYRk8QDYfw7agaBF71vSyqd846XceBwZWHKjPzpyUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro9R7ISVXXJA1zVVcJadHX0ouR0o1aBGW+vUhf6P/MH/642yRaYhZKbcLIWRPXZa6+ZJo8l1V/QxnFjanjzaQdNun46Gz5rKwwrhGHEQ5fAoS0Yvsh9Z3as9JOZuFR8GzD8RKqbF9pyHM2YTiOKEdW+kdJgW03Nfwy/FMoeDwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7TIY01H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d5af11a4so33622465ad.3
        for <linux-can@vger.kernel.org>; Mon, 02 Sep 2024 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725262189; x=1725866989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mTYRk8QDYfw7agaBF71vSyqd846XceBwZWHKjPzpyUU=;
        b=S7TIY01HpKhK6xqLkNv4LP4rDuKCzT/13Ae0LvPjq3nLZekbK1ETAnRUfSVzQYj6cx
         +58ztIZGA3fNtOd72ZkDWN7+xr8jYvufmqb3KjfR8OeKT0Kp6ZyWjjwJ+X3dzk+5SenH
         oHAWB9WyImwU/VbdCmiVZK6Z76KYyNOId95fSNX8yEXvIsj1MAN4GRzQqjXzwKlPrJrR
         6ccQmSf60VwEK3WroiQfbQleXwvIIjax2x/mM1k4zUdkU9klnD5KGrNeY0vHd5zsFT+K
         ghnrwSCMpb//zkq7H8pUSf3w4DIpyRk5j6aI7IC364EaUhmxC47+2QMQxJX8qbgOYuar
         9oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262189; x=1725866989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTYRk8QDYfw7agaBF71vSyqd846XceBwZWHKjPzpyUU=;
        b=AxApo3vCU92FiNEF61Ioj4bLCg25VWedmrplxkofrCxEBwdW0Z88Z0soyPKzsXLUnc
         kA36Da5O9pnO7UTUTS1tWUA7jsOADiHaDSaFnUNkTh5Qu1BLeKXHx+zny9J6q72mupwN
         8R2rhllH5LXo68zS7urbQ39iYMqNSlLF1MH6tPUk7ekdSKzPA/Z1mBVqy2tekt6wWI+x
         5nqi/we0Rs2/6fIhVGQckXWz+b51j+SHUQsfO4Vv3ocgB/SvWYrl6xK3in0IQhxJMSWz
         vw6k43OOl6CScS0ym5ZYismS4U0vRtQzVMh/h7WEPus/QSbXFg7Y/rY6Z4YrCAMoUMqh
         hIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDIrAsest1DIvuWu4rHebNdqxuSBnygk+C3ND3GNgD9mUIzY8sXHcTXEGI48rxsN8ZGwcz6//VMjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjxl1JVz67hef3yI1sX7+TLM3qfVquJZCjVvYzoU5vrZpkegN
	R5o1r6MtDmUTwWzS/a7SUJ/eY2a8eXttCXHnjqTd0TALktQqQ2e0Tqm4St1bWvK67ndTM3LD85g
	Y0OK412PcFWPdbEj2zeUayBv32ck=
X-Google-Smtp-Source: AGHT+IGlftb219Q8PlYPJI38E8ORu4VRICcFddjZUO/s6r0Qf4D8FXpjpOnQuZ48yEbWZOefWdloS0L4RIQmswfahyA=
X-Received: by 2002:a17:902:f689:b0:201:fcc1:492a with SMTP id
 d9443c01a7336-2054612c3d6mr73174695ad.18.1725262189329; Mon, 02 Sep 2024
 00:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240902032837.1513090-1-a1ba.omarov@gmail.com> <20240902-aspiring-amphibian-swan-f65506-mkl@pengutronix.de>
In-Reply-To: <20240902-aspiring-amphibian-swan-f65506-mkl@pengutronix.de>
From: Alibek Omarov <a1ba.omarov@gmail.com>
Date: Mon, 2 Sep 2024 10:29:38 +0300
Message-ID: <CAKyg=SXE5FVW4zHVX5qzsm80zco5A3eNe-pU8Xrzq1a7AcM-xA@mail.gmail.com>
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Are you using the CAN in production devices? The driver runs quite good
> on a v3 chip, but still not stable on the v2. But as our customer now
> only uses v3, I don't have any more time left to fix v2 issues. Drop me
> a note, if you have issues with the v2 chip.

Oh, I meant v2 patch set.

We're probably mostly running on v3 chips, since nobody so far
complained about CAN bus and you're also telling it more stable there.
:)

