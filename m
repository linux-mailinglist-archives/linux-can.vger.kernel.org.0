Return-Path: <linux-can+bounces-1644-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067299B967
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FDE281D4E
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB682140E34;
	Sun, 13 Oct 2024 12:34:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC02AD11;
	Sun, 13 Oct 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728822856; cv=none; b=TyZCxV5useM5Re0rZmldHKrOiRf+vDWWbWV0FOSdO2Em+c+qri9y9GBN1G6mdBrPzYvpbLGAXwXehCVxLc7fOg0KyZWUTwzCsCmOCYXX/7AexT2H3MTWI6bR8PXcS/Y+bw7jZh0sHVVm/ieqiZ+MepeePx0o3wJGGTQPgV7PkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728822856; c=relaxed/simple;
	bh=KVjBzbJn5qvjmNyqcgzY7Gr4rCMtvwarG/tbRhyo/3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBucQ21fvmSprg6q+Dh44gCK2h+ON+KyFJQ+OpNsx7PMNNSHpfrr6ztEB9axH1x8DLewtbbS5t9fbsVs6YLErev3znYdRmFBippQir3AUlVN9AWAkuJPsDMNreBvYfZE7I9PQkux7h5Du6JHk0XeZ7Rb8x1uSkzYnFScZQ80X/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso1238433a12.3;
        Sun, 13 Oct 2024 05:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728822854; x=1729427654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVjBzbJn5qvjmNyqcgzY7Gr4rCMtvwarG/tbRhyo/3w=;
        b=nsosrqQRWlaKRDafKfgnQVcdASsYnVnz1exxdtRm4I2DN5UmcCEQHQzIwnUkLVi6Wm
         kkEa2gjepA9iPjdEQOpoq/eQAUgy6dBQYRnhtXPJ0j1E2/fbrY3a/xKcL0UTB89ayETN
         IcNcLy26Z9P9N3AXs0P0WqhixFt27m0nd+DrnujDJAkySxB6D4mylX7HZg3VRfYumdql
         Mxh6YUdrObtGmGHbjN8F/cerlntAw0rVFkuGpQ24z5vBmvAJl5ILXm/9UAC+Lo9w554f
         POa0qT7J1YS+EF8eELgQePlt2ZrK85SVYQZutpWgWEaF+O7VWHjywNXagOiy3PhjaFlL
         hlEA==
X-Forwarded-Encrypted: i=1; AJvYcCUXs2Ba1KGOom7auBxPvcE3OolVVsN0tTzTgm4gDv1bKrVngIPmdiiwgMwW5La6Ps/tHXVc9JLS7fPY@vger.kernel.org, AJvYcCWV5LeWuHc3NFyaq/PhpiI856ayZ48y/Ofb6ufclzemUgrVWY4nXbky/cF+gVXxAifiRxHSQrrc@vger.kernel.org, AJvYcCWjr2Pf/aCN1TMRbbjrWg4n/UkCorm9oIk3mCAkUtSN8HJrt3PBjqu3CbFztla0gZxdHxaFYh7W4yft@vger.kernel.org, AJvYcCXX+lC9dAZHdOE3LQX18rI66cVu2zhWippLxEIPHjAhDyG6ZywVoJtIIaqBzSF5RBvreBUz28FHCNxFWbFo@vger.kernel.org
X-Gm-Message-State: AOJu0YyeD/jQzFQJUUZ5f0D/nZTje2olVdJ4l0toQaY1uvokcZDzNP71
	J4vyZ48Kf/WXpB0AMNZ9fr04FQzdpOflI2pUVfQuIsQzCq2fz2zHvO45rGgMM0RB9KqfPJZBWUm
	6nBWvid7JGfcelvPgAkxx8aK45g4=
X-Google-Smtp-Source: AGHT+IGjIfuYgWXbzMHWa/jQj9mBLzXL4HpmJdHa8oqu7nEyDsnHglrnWDthyUaa2cHW45KewKrlHL0wkF0rMDpZvu4=
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c95ac09876mr8889087a12.3.1728822853466; Sun, 13 Oct 2024
 05:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-6-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-6-9752c714ad12@baylibre.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Oct 2024 21:34:02 +0900
Message-ID: <CAMZ6Rq+Rcnz3oiE-r_K9P76kAS4ssR4B2_VqC_VH3sbzYNQaCg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] can: m_can: Add use of optional regulator
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Fri. 11 Oct. 2024 at 22:20, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> Add support to use a regulator for the core. This is optional and used
> to register the dependency on the regulator.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

