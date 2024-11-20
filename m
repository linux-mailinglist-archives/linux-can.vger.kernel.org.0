Return-Path: <linux-can+bounces-2142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7969D3A98
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 13:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582531F21B08
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5919DF60;
	Wed, 20 Nov 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYcNmq+Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EF172BD5
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105440; cv=none; b=hasjq4Ot+OxXOBFDFPmu+1ZLW6Z8VgwrtPvw1VCyHn92vaLakfHS0z45+GE0N4dj4BSAP9liOIpUqQaEABazOOK29NENONGl56scBSslL23ZWO9y0Bf63Y4q/mIlY7uJ4ItWXtN5B3Nf2l7brNRl3pTFpBH7jJQNw7Y0M6AV4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105440; c=relaxed/simple;
	bh=vALG52keph/W0kE9R9DQTvoC8It0x72R1Gagul4JBwk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mOgs0AL+NdqQxbn0vosTmV7pbDzsccOZjH56QV9MN0gpsgEZ/9WkWGC5zZN6sML7N8dow2DqCSO/gHe47BGylegFLLdM1H1eV2ny/LUp3cjgkyXAn4eYarAGDubvnCihrUGQ++0LQ784F1M72MGmdIZpcYxfzR05Z4rkwL8A5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYcNmq+Y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da2140769so4729277e87.3
        for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 04:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732105437; x=1732710237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSJZ1W57ZoSqqLjkRll8IM+U6gM9hct1Kui4s1a53A8=;
        b=iYcNmq+Y/E9Esv7Texj5l/R5gUQW+vrRF0jQ8OIeW9XPRBgx5XNy50Wg2B5a2HE/si
         KBcQWbqozFEOgCdVYB36owox1uN7hqpeq4+TZEpK+Ge1Vwg5NQ/TrvmLNZ+kD2qMlwor
         2geLzaL5dDm+FktIM2TeKJAsmc6PS9FDol0YzKv9mMUt45Pof4CchUrYvhhb8af2Vizn
         ABwlaS+wxRyd8V5dFfPpXUoFcNDKzq0/oJmaXm8LGvUXzFOW8vFNM9vQeXZsZvOuDgTe
         rdnRcon7CXCkzlQbSxbG8OuS9R9iEz4oFLEreZxF7RKa10ciY8/TnGyiL9kvX63lkF0l
         KORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732105437; x=1732710237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSJZ1W57ZoSqqLjkRll8IM+U6gM9hct1Kui4s1a53A8=;
        b=HaeKU7/NDdG2/jXh7JfccphXrujEAUK5dMYxHQjbprx7wERG5U/PYxkHgnMqZ0cudS
         nbxEaaBldT/QoYv6wr+/m3WciWtrGCl+34ecuGN+K03VSG9r2EZD/sW0Etsd9rFy1JGa
         v8oEreUiOmhWvRdfUfTeDoJvGC0ScuY6YGe8J2F7RyXDX6iWeZKef1X1PfAqUiHQ3NAt
         zKYc5B4DPJAFZJk5VamM0hqF9HyzPqGgiITqzwEmWZnadK+E2HGSP2R0W137M3bhijGI
         4RFSueOIhITgfOnulSI8jL4SsQRAuN58FHqoUUPRFrIFyecKoV8au+CRR8XDHOwpZuDx
         7kjg==
X-Forwarded-Encrypted: i=1; AJvYcCXSrJse80EG8Z9kjqVNT+VZdM0kvNLW50oNw9i0a73ktujEshY/wVnuGub6SEGWBYjehXmcjsCGv8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHl/WBJO4SbN/mIBI9o98PL3eOQ8v6C0F02+OXreZ1ugC0Tqz
	N7LiMHkuKrEbLvouFALxTPYGHKsa7LKVofincCfikdIN4GyeJSgfvRD5fJFhCbFXpTuEN9pHP4r
	evr1nKIwGFhtemttbZu6+f2U6YCE=
X-Google-Smtp-Source: AGHT+IFVT59cAt39hKcNtZJ3C+DXLYo4WgI+/MdcksAV7hj7irjI+FkLqdy6PDn0OPGx1WkXukvaVVEpqspj/GCD304=
X-Received: by 2002:a05:6512:3b2b:b0:539:d22c:37bd with SMTP id
 2adb3069b0e04-53dc1367c32mr1034544e87.36.1732105436947; Wed, 20 Nov 2024
 04:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Nov 2024 09:23:45 -0300
Message-ID: <CAOMZO5CvorhgM0r0WssdPxu2Q+=QuaLh2m26sekn5TadUip=RQ@mail.gmail.com>
Subject: imx93-evk: Failure to run flexcan loopback
To: Bough Chen <haibo.chen@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Li Jun <jun.li@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Schrempf Frieder <frieder.schrempf@kontron.de>, 
	Mathieu Othacehe <m.othacehe@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am running kernel 6.12 on the imx93-11x11-evk board.

I have backported the imx93-11x11-evk flexcan support:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20241120&id=ed73790b6ba7e44b6ca7129dbe564c50a20d9f45

I am trying to run a loopback test:

~# ip link set can0 up type can bitrate 125000 loopback on
~# candump can0 &
~# interface = can0, family = 29, type = 3, proto = 1
[   73.313897] can: controller area network core
[   73.318472] NET: Registered PF_CAN protocol family
[   73.338241] can: raw protocol

~# cansend can0 5A1#11.2233.44556677.88
interface = can0, family = 29, type = 3, proto = 1
~# <0x001> [1] 05
<0x001> [1] 05

but I do not see the eight bytes appearing in the loopback.

This same test worked on an old 6.6 downstream NXP kernel.

Is anyone able to get flexcan working on imx93?

Any ideas?

Thanks,

Fabio Estevam

