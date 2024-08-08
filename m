Return-Path: <linux-can+bounces-1183-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC094C5B4
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC8282A58
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35F156887;
	Thu,  8 Aug 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLNsTjOq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406713D8A2;
	Thu,  8 Aug 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148856; cv=none; b=eX9aTdbHeICcItJ/u7oyzAcmN+YlaqW/jOXvI/H85oYjXggOVpKUdoKAUZWkliJznbSZCveGUteWjcPhG9wdoTX4EbDmdoNxQ7t4ePabDSviFxsgOKtWqEY3jWgZOsCqtWjmiKgzGcG10+8Wx65rgl+Ptb6zwlNJAdOp/c7L4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148856; c=relaxed/simple;
	bh=dSe/NQDOZybyAI/QEDENLBxxuP0YnOgfcnO74JQuNRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cLctz5edLRu33Y2fR5P+wPvgUG7nfDHFFk2hcL7R1ut17NXIlcRjjWuuIZGpEvzKKTtWiP+C9KNugLOAI/piBJ58ZaGTHPF/afO3Yfah8liaw+U+In9BlCHvz0jhDS4L18cVQbYhED+AVnGATrZ/FmUwa2VvElV7ZCuKrvSqbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLNsTjOq; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-83120879efcso450185241.1;
        Thu, 08 Aug 2024 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148854; x=1723753654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gOD9qHt5HUAzpjDzA7tGTtcYiqR7JCDvKLS0bt8yaw=;
        b=gLNsTjOqvBskOxWVm7pXTkYYtDb72Ldw760X57nSDjY6yROmZEp60ci+xTNLyp5zMS
         VFV/mJC14i1fl7mOlMvPGAs1BZIRyKXNXzhjtQuF5+2ID3bDJ/cFp47W0zt4Jsseoq/j
         4aVE/C9R2JB+eM278C8y51vxBQzcU5/U8Hxtr9GC3/GolSXP0ydC7/O10Zeoefe1cbL3
         GtpQFouLu7t4tJ6zSBaK7gpQe9FAOnnSVOjwwaS3D1wSLTTZIht/d0tuMqr9mcZJosLm
         Zq/nLkj19+htLnKWG8hHsYaoTLaWZ69eW/kCNfMApTJO+Sb9g/ie5uD9JwkwAhzPcwlE
         h4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148854; x=1723753654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gOD9qHt5HUAzpjDzA7tGTtcYiqR7JCDvKLS0bt8yaw=;
        b=wBNxsd0+/l4CFUFwaVNca/Z4ssHLnrd5rJu7iK6M1Nx8SZ8W9FP03MVUTvfRn0+egs
         VEn4Weet3NQwIT/L0m68dnhk58IXeV1Wr93m5XCtTzmv3Wd90kh0cEPl37jSgmB3KRLO
         25uVhgr/4aPGJIlpXK0mjPsZ3BySwB+PtrqGgfsocsQoVPBXSdxFnLG+RvIOH6e2Nv2M
         t48opdkxvaT+L46KNxTbwgV0Xp8o9xXfXR0NG0vUL2EHOZnjI6A6ePyUICI3gWnuMotE
         IarQNrBrKX0WNG1oi4D79OmPPlrRUHgMyQekJ5XsN9ab41jNDG980MVpQRm5ITx4TOIo
         moMg==
X-Forwarded-Encrypted: i=1; AJvYcCUN6iJR7HxeVk/gfclf+dPGUn7X9t0VG7uSrSbp8Rf0yiiAHsvZOssm/hpLKkbQh+fq0bHJypHPytWeh2QEFRjE9SLSA06+ttbOL1N51+MHBPqN+ub+sMkoVeLK3w+0dnsfyfZnBCF/Tt5V8hDSRAf038x2w4m2HxHgvSrdunkO
X-Gm-Message-State: AOJu0YwypKRI+BspLE2vskwNdEJzN2IISrb33eXN2xJJ3ov79l5QaUzj
	ZAEFXVjMc1+V/H+FlggSnQmvsvJuIH5UydTPrvLjBa6n8mwyHdN8
X-Google-Smtp-Source: AGHT+IGW2UA5p/eZkCZn8DEwKY8mnsYkSQuCjz251ezP2c+lz/BFeKpTNm8aOQnLxWNlMZckWfAOGw==
X-Received: by 2002:a05:6102:2923:b0:493:e642:38b1 with SMTP id ada2fe7eead31-495c5c37076mr3749651137.25.1723148853569;
        Thu, 08 Aug 2024 13:27:33 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c09925db4sm1946473241.36.2024.08.08.13.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:27:33 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
Date: Thu,  8 Aug 2024 16:26:58 -0400
Message-Id: <20240808202658.5933-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a warning with bcm.c that is caused by removing an entry. If the
entry had a process as a child, a warning is generated:

remove_proc_entry: removing non-empty directory 'net/can-bcm'...
WARNING: CPU: 1 PID: 71 at fs/proc/generic.c:717 remove_proc_entry
Call Trace:
remove_proc_entry
canbcm_pernet_exit
ops_exit_list

Instead of simply removing the entry, remove the entire subdirectory.
The child process will still be removed, but without a warning occurring.

This patch was compiled and the code traced with gdb to see that the
tree  was removed. The code was run to see that the warning was removed. 
In addition, the code was tested with the kselftest
net subsystem. No regressions were detected.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 net/can/bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 27d5fcf0eac9..fea48fd793e5 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1779,7 +1779,7 @@ static void canbcm_pernet_exit(struct net *net)
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove /proc/net/can-bcm directory */
 	if (net->can.bcmproc_dir)
-		remove_proc_entry("can-bcm", net->proc_net);
+		remove_proc_subtree("can-bcm", net->proc_net);
 #endif /* CONFIG_PROC_FS */
 }
 
-- 
2.34.1


