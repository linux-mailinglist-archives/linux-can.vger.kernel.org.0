Return-Path: <linux-can+bounces-2718-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D215A26718
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 23:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA7E3A3EC1
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601A1FFC7D;
	Mon,  3 Feb 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoFbihVm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259C7D07D;
	Mon,  3 Feb 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622879; cv=none; b=QAzO7wcRJNMZNBgQg3Y5Jgy9sy0lIDQTndHdpDkeoG6T8ml0VbtWlQksta9A+Om8yQ4HmZPOEHvClmqZhzTZnWKFiU0QrrtKmaVZjOF8s/rX3Q46f0RYywlHCr7gyJvguZ09SbiM8rb9iS9f4SH0HyqTyxIXsTHr2O+X6IYkxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622879; c=relaxed/simple;
	bh=hHTSotaKXn6mqlfsuZRFL7mUlXbYedRwitXa3n7zsZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=is8bmuqTNvJnTcmZZVmS2EYNqudnB7YpgZdypyPTwOMiqjhwcQHt7xiauLCsurLHbrkIPDMlzFavRtyzqq1xPclGZhLWguvfGdNvjkud55WV/Qe5z3kIxyUbu6JEGPILdX3udFbaa1icviySmREAopF/SO3z1T2LwYmQR0f2K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoFbihVm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f664af5so57747505e9.1;
        Mon, 03 Feb 2025 14:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738622875; x=1739227675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNk8vcXhWS2lnex0vmdV4Bh3p7QN4YitPegQzBHEFfU=;
        b=DoFbihVmVNRM88GV2daMdqjDrnEQWHVQUCC9vjxRsvivPBJWkBgcZ/EJpOd3G2CGMO
         V5N68a6/ySKJQ4u/SprajcG4Bo0nf2y1691vRVoOnzTL69l76J0lOqS7/eN1z9Skch6C
         gaCa8VuXvc4VoAlh7PXl1WNtaXaB7KlPqjXpb+CGDZusFu7dbyp31cSGdhq+vt3aTfzY
         DQiQYorrk8rT3VKHeLBB2wvLGTftoYV4ETZhIMa9w4WKEB18/r5igwPctryfwkISe3Ut
         mH1i522jk+xCW29SnmfN1YOuzukVyNOvn7uPWIdUkeiErcqR9PS71Mv4oCZmNV/QFIbl
         fZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622875; x=1739227675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNk8vcXhWS2lnex0vmdV4Bh3p7QN4YitPegQzBHEFfU=;
        b=brryxdv2D9iuw+DfNg4rWv6FE7FbtYEq0tl0VS7zB6uhjDDZNWYyJXU+AY40Il37ms
         O/BcyOwiYBNKxu5+dTbcmGawQ/GnhAy5FwQHdPsBzRuOzZMhsZYE/7cl6jPuiEVtvF2z
         kKNfw85IfL0+hmUysfc5T1pGpjEydftQANIZ29TcbLANhXMP/0YLEP5Cv+3/3HMRsUzg
         Ub8YPhwOAaxtCDbP3lJtXh6ANWD44xTq/OxsRMaUItgx+APKtujD+n1g8KNshbtH0WO6
         AH68rU48PMZtplSb3YXO0rSqZgog/DcIYIoaNkaLp29KzPezjYc/QtdcMTJVXxx2QXI9
         wjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCURKqRPM6e9HPrWg6YVCs2CtKB4Aspbo0PGFeqpEKgzzBmk/Q6MduUxlcPZuEwYMy6VqMd145tJ@vger.kernel.org, AJvYcCWgoKUHGDit6/RN2hV7PEkB8CAc7HLA0aU8jaIKMOcfB3/bNUayjsOOSKOKxh/jUqK9hD89pSDVLG0=@vger.kernel.org, AJvYcCXGwj0GvdgrNSEPcknWWaJPbciIz3cpC6vwA6CNv5cZMHErLcJL97etntlEdJhsoZWDzk86fT+G+Iu0@vger.kernel.org, AJvYcCXWwkiqBD1NGtJ2G8NIXmYgSfTAoy5XIrHAkBeQCMOfbR6MmeI8SUID7/Uqet1X90aAlu6p8M0tfhtgzAcj@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7kIL/mkNDwnoCLrQT/eM5uSrX9+FVmX2bDZL1MwyNL6/8pOb
	8GH6uvc8KzhAS9mBn2s/V6nv58eoDuA1SIamjL277EFzx2smk8Tf
X-Gm-Gg: ASbGnctrwv8LxmLbn+SKIcupgliBLNXRITFwHJocfU0nQt8yChzZX1US27WHSZigOhD
	DGvUrWADJUfFKKKmTa/JejvxAZObeN0B7OXjwbyr8wDgon3MAqVM/3dutRdmNVmtZ7LX6CRp2zM
	UFhT37YlKrnv6leIc3S2lSomRqCeqoCA7UihP69hePXUuS6ELfVKhbQY/KylzU2nGNAYi2PEL7h
	Z+xYWprLmxI2YZjnebcCE7dMG0+znlHT97HKjh4r+Uw2s7MqhQ4favuP3b4ndR32MrxrtIOcDwP
	zu0=
X-Google-Smtp-Source: AGHT+IE/EFKa2c0I79aiOGpHh/J+3xdNGIulwoDYDqj1uGt8aSw1iorBtbN/fXpYftwxNNhOalmTpw==
X-Received: by 2002:a05:600c:870a:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-438dc3cb7c8mr198340375e9.13.1738622874881;
        Mon, 03 Feb 2025 14:47:54 -0800 (PST)
Received: from ffc.. ([5.224.37.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81911sm202559165e9.38.2025.02.03.14.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:47:53 -0800 (PST)
From: Reyders Morales <reyders1@gmail.com>
To: kuba@kernel.org
Cc: Reyders Morales <reyders1@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/networking: Fix basic node example document ISO 15765-2
Date: Mon,  3 Feb 2025 23:47:20 +0100
Message-ID: <20250203224720.42530-1-reyders1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current struct sockaddr_can tp is member of can_addr.
tp is not member of struct sockaddr_can.

Signed-off-by: Reyders Morales <reyders1@gmail.com>
---
 Documentation/networking/iso15765-2.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
index 0e9d96074178..37ebb2c417cb 100644
--- a/Documentation/networking/iso15765-2.rst
+++ b/Documentation/networking/iso15765-2.rst
@@ -369,8 +369,8 @@ to their default.
 
   addr.can_family = AF_CAN;
   addr.can_ifindex = if_nametoindex("can0");
-  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
-  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
+  addr.can_addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
+  addr.can_addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
 
   ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
   if (ret < 0)
-- 
2.43.0


