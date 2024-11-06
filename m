Return-Path: <linux-can+bounces-1910-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4E9BEA98
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 13:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720001C238A0
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8051FBC9B;
	Wed,  6 Nov 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="awczOLZO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6E1FBC93
	for <linux-can@vger.kernel.org>; Wed,  6 Nov 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896727; cv=none; b=NCCArWu2zHlBpZwKLUvw+OY6yub4nLeI/x2exCYCNzDUU/xLYsUt0dxD/bXU4xczYeaIImOafs+9kmSfTboQnRWTjnZ6lS382lxm9vCmS/5/fA6sSOjQ/MrpoUbDvfHEmGuqO77uMTLEpDHFl1fpQMIjHUPn0oHH+za4+yNdc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896727; c=relaxed/simple;
	bh=CDjC6nWvjQXpbyv7qr5gnCApA/5Ifno/sV/kMz8RsZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDt+1eGjuEwIEYOQKh0gyAmyteK59zX0ZbKjBMxcf1ymyrObMOWgrUL03u0FfFs7YeDYHJzcj2/cvWe/l/FefO8LG/YxQuwWTrBakUqEWuiCpfHmDliiGMlf16jSYoCyuy3f8EzaVzqvqeXcmUmyJgOcIVNNEG26Nc0A8RRIF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=awczOLZO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20bb39d97d1so63701645ad.2
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2024 04:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1730896724; x=1731501524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b63lFEryEs1cJbfbsaRBAKS7BzP7xAl1csIxo1LU5As=;
        b=awczOLZOZZL57ekw2AJd6jA3U7BwTfTloYqdRSYJO+bNRGQXifFn3s9CEPyQgoo21N
         XCAHzcDHjxi5lbFAiolbUJ/X/BbMF+EfzdP5MGKl/6tDmZ31fPI+7Ze5jVru910eRQQe
         qhLOnkNHmZPxV9yZIwBrJYOaMkWaVT5OTlwvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730896724; x=1731501524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b63lFEryEs1cJbfbsaRBAKS7BzP7xAl1csIxo1LU5As=;
        b=TGWI28k9Gao9yhE6RzzAU19tEIdf3WXS2QVZMl/21QKz/D4tvL0qRoKfZ3FmGWaM43
         JPsjBfid14g3sO4AZwUGo8mOi//Wcsy/ZuA1RdW/3Ym+yTenKbvWmJoV6+yJSonW1SuD
         V3qVWI7zgHgIKlqTDOC7yttvjVgDLiw2ol6qno6DIC9kqx3kz7dA5Sbd5CRC03HbrFSl
         Yj5UhDAdNo9wkQDmBpF2ICONqtgNZ0K8k+8JizJr4TYwIs+FLdas4PyXaP3XEZYhzz4x
         6G7w+u1+on4aTvALCSEf6jjWhOqSWmIK4G0cpRvSsWQa2P8IBGQkFt2djI1gra2lrB5y
         /P6g==
X-Gm-Message-State: AOJu0YznS48MndkreVv5u7PK6qldAo6fBj4dZK4eGFSXqOvXcCeXH8ni
	vDKM8XgrkKHqn6sZ9kyWebdSJMXLMJyyeWphQ0wh8PhNs9CubihJ82C+vFVnI5S8WppDSBOY6Ts
	=
X-Google-Smtp-Source: AGHT+IES+ivS48rEo8MR51lJV41yaBz2AAT6263Iabcnp7tM8pjU+lxAgPBWCuqL+VE2XHfRngXMHw==
X-Received: by 2002:a17:902:eccd:b0:20b:6e74:b712 with SMTP id d9443c01a7336-210f76d66cemr417957745ad.45.1730896724552;
        Wed, 06 Nov 2024 04:38:44 -0800 (PST)
Received: from SE-151.formulatrix.internal ([36.73.154.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c1543sm94380855ad.186.2024.11.06.04.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:38:44 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: linux-can@vger.kernel.org
Cc: martin@geanix.com,
	mkl@pengutronix.de,
	msp@baylibre.com
Subject: tcan4x5x is refusing to configure device after os reboot
Date: Wed,  6 Nov 2024 19:37:00 +0700
Message-ID: <20241106123700.119074-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'm evaluating tcan4550 on Raspberry Pi 5 and currently using tcan4x5x module
from 6.11.y tree (because I think there are some performance improvements
there, which aren't available in 6.6.y).

I think I found an issue if I set up can interface and do os reboot *without*
setting interface down first.

[    7.917431] tcan4x5x spi0.0: Detected TCAN device version generic
[    7.919833] tcan4x5x spi0.0: refusing to configure device when in normal mode
[    7.927054] tcan4x5x spi0.0 (unnamed net_device) (uninitialized): failed to enable configuration mode
[    7.961160] tcan4x5x spi0.0: Failed registering m_can device -EBUSY
[    7.967940] tcan4x5x: probe of spi0.0 failed with error -16

Based on above log, I figured that "refusing to configure..." message is from this patch:
https://lore.kernel.org/all/20240607105210.155435-1-martin@geanix.com

My question: is this expected? If I do `ip link set can0 down` before doing reboot, the issue
disappears. I'm not sure if doing `systemctl reboot` should also set interface down, I think
that's not the case.


Regards,

Renjaya

