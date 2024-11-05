Return-Path: <linux-can+bounces-1888-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7A9BC802
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 09:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B0EB2103C
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016521AA785;
	Tue,  5 Nov 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="FG24DBku"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E018CC1B
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795385; cv=none; b=JlK6b+nnGTMnzYfZQZhU6PDxjiOlnaEf+zjklRHArFseRaOBTu5Mx3Ghdrt2Wy9dFhWTzpMu1l5jOYx2ZS9fC55XMQmcTHJZBN418MiOF92j+h7azbaqrVnOSQlyHDL+6yPLz13TTvRwXv6eHslMFxvL6wAUVHqa7zETlu2uZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795385; c=relaxed/simple;
	bh=DKviTkOPK6AepnCwy7wfGZl/sFz8p92HRrn2hcBRsKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkkPM8fIzHFVoLxCrw9qMVdRPclpI5139UodI/2y/SpxU90a9+i52WjtoSoAFNKzgK8VNXYONAcdJg6JE4XbBRIxGvSG6yiPN38TY0/ev0adk0C4qeyvfVeijd3mPag7G4vJQVBVlXXzWvevxmnmf/3HXBGx4ianSa0iP2AWlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=FG24DBku; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so47837415ad.2
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2024 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1730795383; x=1731400183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8DT/y5CPrvl4cEdh4ZlvmYa4bqm/UEz/hy4v4qAVH4=;
        b=FG24DBkuNQqCM8cBxTgezNXMAmQrXLqYNdsjhCMTSvDtMf4QxZpyYavf47RbJcDy7i
         vXbgKm++KC2pV0VNyw4lo9BKjpjcjSGl4mkaBorpqoe30hq+vwUYnQhi65hXcl8nJ+jl
         EtoFW683KYO18I33hQ3IMtvCdxmQfCsq81usE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795383; x=1731400183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8DT/y5CPrvl4cEdh4ZlvmYa4bqm/UEz/hy4v4qAVH4=;
        b=U9mOnaH/eWp+gbYFhNPa2vxbHDP+NPKJxvMxHEsnp4Z8mJfXOhoZ2N3G0fzSBWU8e/
         CenaKzn9vy7LqPTvI2lH5tVsUOaMgf8utcsJHf28A7SEDPoY5yXQl+Hb0P+8SBsfH4zr
         5OmySwi0BoHGoXrQEw6Vg9RS7TOihd/zVoLnEh1ZKzgPdLx3bEFCuPCosFso9e1mNbjc
         nRHja9xxYvgNt+nNJC+VZU1JkfF/SH74o/pwWokqfDjryMKStbAzfpbhxnN7Ot7TdsOC
         08UMu6ddyBYF79SvFYnpzBytBPFE4VPp+ftchoejB4K8fwARKuT5TH6zFyAZBZ/G1rC8
         wiaA==
X-Forwarded-Encrypted: i=1; AJvYcCUAVO9uEaaIr6CpeWseCifLUsy39LH37CWVrgCdKruP2O1RncgPQBO2RR8LeDKpUIgWhph8lWAAhxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGueh/vAReJZuQKVF539zCXW3e64AYjj3UuDQHz0pWuEHLOfC0
	xtGsek2HW9Ck2EeIYkwFoMB4Sbt4Wh24McfaGxJwzO/uHoKI0oOP+Ln9AFzZxw==
X-Google-Smtp-Source: AGHT+IGlXQE1AGAX1dkvcat+1TcXOXXdR4h+L794/7uzIp7WcAIK8pX7X0rPQItDJQy9EC54NXNKlQ==
X-Received: by 2002:a05:6a20:2583:b0:1db:f087:5b1d with SMTP id adf61e73a8af0-1dbf0875bd4mr2976098637.37.1730795383582;
        Tue, 05 Nov 2024 00:29:43 -0800 (PST)
Received: from SE-151.formulatrix.internal ([36.73.154.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa44a34sm11388173a91.26.2024.11.05.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 00:29:43 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: mkl@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	mailhol.vincent@wanadoo.fr,
	manivannan.sadhasivam@linaro.org,
	schuchmann@schleissheimer.de,
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
Date: Tue,  5 Nov 2024 15:28:01 +0700
Message-ID: <20241105082801.32475-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
References: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Marc and Sven,

On 25.10.2024 15:50:37, Sven Schuchmann wrote:
> this looks good to me!
> I have no crashes here anymore.

On , Marc Kleine-Budde wrote:
> Thanks, can I interpret this as a Tested-by: and add it to the patch?

Sorry, I'm also experiencing this kind of issue. 

[  217.906113] mcp251xfd spi0.0 can1: IRQ handler mcp251xfd_handle_tefif() returned -22.
[  217.913946] mcp251xfd spi0.0 can1: IRQ handler returned -22 (intf=0xbf1a0010).

Even with this patch applied, I still can reproduce the issue with:

cangen <can-interface> -g1 -c8 -L12 -fbx -I2 -Di

Regards,

Renjaya

