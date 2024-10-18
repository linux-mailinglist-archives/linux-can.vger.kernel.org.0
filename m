Return-Path: <linux-can+bounces-1718-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01D9A48DB
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2024 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF68A1F22821
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D118D65E;
	Fri, 18 Oct 2024 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVeoEcVZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2213A244
	for <linux-can@vger.kernel.org>; Fri, 18 Oct 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286596; cv=none; b=Jwup8ZLvGa3Tf24g9OQq+SEGWnkUwJHuXCAg3TMm3m6JmS4SzlyfR7p394kELrlsq75Yq/mIfRwL10m1EzEc6EtQhOZ/0C6YmdC6z5AEQbA/BpHjCC1MOsEhSfMCaJ3XjlexvO319sQNacXxWRk/GDC7gIklXm8OhkkUAh/8QbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286596; c=relaxed/simple;
	bh=obTH7Hu30rnVPMeWyxvh3cZyD0Z3wVo+ujdRB7fxtTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwgZtRfoynPESupJmZFrGXzR9a4Ghg7ZOMWn+L96eAEDuwhrDsCEMwjQRPqcCCeUMviEy5EjSYkTwYilT1Gtfn7DWI3zzqVLNHTiEsrlKnh6bEHx7PkMeUrYKewDgFrbvPtk4Vp2jjfE6VHL89oD9D2J0tJXfteHhJJGGNBlr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVeoEcVZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0c40849cso371766166b.3
        for <linux-can@vger.kernel.org>; Fri, 18 Oct 2024 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729286592; x=1729891392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnZ91v35tkt5Bjsk0LNwLHOiJPAj2CEexom2lMzjmFk=;
        b=dVeoEcVZG7C6bPx13Dv3qtwAxbYJvZwGydtzU0OxVqIPmsm8Z7v1EBZcfX3+vtxzL5
         zjDtTxlDZpGT4sai3B6vCjJSX8ESLfEYbqtj+jPNU13MJYzFL71F4O79JXlhYwmAIaqY
         mkxkWTehIBITMZHLdmaLeNmoNeWGwz2KfxA8HlwMxSl52aQ3keuk4LEsOiJZgDNhVnDm
         8/iWa+MXfDVhOfmkxQec90WLnfMRY8j/EemWvojnI+zB8kQQECzydirMZnO9nOQ3d4+a
         3j61PS0JP39CZCV8+Tkxg6/cIYSmxxQnhuW1GfT6WVGc6mnuteiAD4+4iEayFH4uA6Ks
         BEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286592; x=1729891392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnZ91v35tkt5Bjsk0LNwLHOiJPAj2CEexom2lMzjmFk=;
        b=SF5wgScsb02gswDyfcacyZ+CAJCSjadF8KnIQMqjGLpHhmoI6gjjf80d6PhCF0ktTR
         PR9jcBuBOIHRy6Qexnp+wDA66K3yx+jK/FdOyRgoRV65H01pFh008nSkEJHm1MWMEC2a
         qv2P76+f5O9cwAwT6QqTKtZwUPI74s+1HF1Xu8uzOLXdUowDi6Fjvs4wRq6us8h6mZ+G
         NwVVvzI2Yj/2bmiPELYw/xe+0N+gFQQ+UPe7m3vGSgB2t/tEWpMKq+FveXYP3qR1YoUC
         5vuo3+DaV2geAQJK3IO5N6kL6T/CJvqZjQ2rCjXz2tp+i5yNgp3NHix+HXTTmgIhJesX
         pqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE5tgyZvULX3iHDlDXGbmAtrSg2hQgRzCGj+uGXqv/cTOwcqG1GvLBp6MiNc2AnOoQeZw+S3/z4x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq9P7NY0AMzkKbJKpg31emOgEo4PhL7cBNVoAAwR/hYGhnmEP
	xbUXTiREP/LvW8wb4mKre3X+bP8ZvCIhtwVcUCFxOOcHCxEa6Qsh
X-Google-Smtp-Source: AGHT+IESz2TKmAQnjaujcRXPZbIS+t/nxPGS2Pfet5isXJZxvPeNdXZiExsOl4072IcMt0hxZUD1vg==
X-Received: by 2002:a17:907:7e92:b0:a9a:1918:c6c6 with SMTP id a640c23a62f3a-a9a6996a697mr363582666b.8.1729286592183;
        Fri, 18 Oct 2024 14:23:12 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc4db9sm138764166b.131.2024.10.18.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:23:11 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: ak.alexander.kozhinov@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	max@schneidersoft.net,
	mkl@pengutronix.de,
	pabeni@redhat.com
Subject: Subject: Alignment correction
Date: Fri, 18 Oct 2024 23:22:01 +0200
Message-ID: <20241018212201.31595-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMZ6Rq+Lx5171bcshugrm7R=ipCKTGhdtmAQO=5M62e+e5zFiw@mail.gmail.com>
References: <CAMZ6Rq+Lx5171bcshugrm7R=ipCKTGhdtmAQO=5M62e+e5zFiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Arg, I forgot to point out the wrong indentation in my last message.
> The second line should be aligned with the first one.
>
> You can see the problem by using the checkpatch.pl tool on your patch:
>
>   $ ./scripts/checkpatch.pl <path_to_your_patch>
>   (...)
>   CHECK: Alignment should match open parenthesis
>   #217: FILE: drivers/net/can/usb/gs_usb.c:1426:
>   +    rc = usb_find_common_endpoints(intf->cur_altsetting,
>   +                                    &ep_in, &ep_out, NULL, NULL);

Thank you Vincent. I will do v6 for it.

> Maybe you set the tab length to 4 columns in your editor? Here, the
> tabulation width is eight. If you need some different settings for
> some different project, then I recommend you to configure your editor
> to rely on the .editorconfig file:
>
>   https://git.kernel.org/torvalds/c/5a602de99797

Thank you for pointing on it. It looks very interesting to me. I will take a look.

Best regards,
Alexander Kozhinov

