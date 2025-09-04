Return-Path: <linux-can+bounces-4460-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B941B4305A
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C67565D6B
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675428153C;
	Thu,  4 Sep 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQf1d51o"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8384E07;
	Thu,  4 Sep 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955841; cv=none; b=GENNSjIKgYTqOEbhmfoNZBw9sfcPsp5d5SXsebJ9YOrZ0EU5AfXsxLQyW3tiLlYkYFvRNKonw/+J7Vc80PL+wDJJd2u2bf0PyzLTpGvVIEMKuoawVNhN/bmHNM3yz7siZGw0w9TVXISYLa3W/hgUvNKet6pDZzBlhwACYjBqYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955841; c=relaxed/simple;
	bh=EejBiLCxFjywog9sanmt7MIEAs+lWXOyyyaShAeNxJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kjfq3nkujJ7e5vyFtiwr810tEMIXM/K2o0l84VKmKgPQ2PiTMRDQM7Ck6j38AVLTg7mrube3ZH7A9XQ5WIczpsbkyhaRDTxT1zta4nsJe5IEQFu0nN1uzZ9CHN7LlhJcwyk92wFeAVKxITWyfDzImaeLA1aGgDptRhQ1bJhBoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQf1d51o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2489acda3bbso4968025ad.1;
        Wed, 03 Sep 2025 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756955839; x=1757560639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwlGz5VRP5ZkPZgUDr33RtSbQBaIWanoj51psutpytY=;
        b=GQf1d51o0STNXobnIiFyOeVVBGuohSOGQFoSalQL8qsJGEfthBCSnm1pxFifshmXB8
         AIrKm7BNHVWTS8UtuJhSkijp1+5ElI5tTe8B7UGRLCO2gGdQOXzjMH+VlCknXXULSdXy
         PtRZB+ntSweLyyW/WvmwH0amISTJxRwFRzbd/PlYwurpFRT6pL5ZYGNBgwFPWIysBTvz
         NrSxd3yYnUtJbqG3Dp0ksg4NGfdNGnea4RDys1kERDknlVBKR9RabLkmc1ZboAI609Tq
         U/TmiVSAiSFB9FMWj92S72vSQn7fsh/o0inf/TtZ/rKQFvzd7AiTFwCeUcXR6CK0dSH3
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756955839; x=1757560639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwlGz5VRP5ZkPZgUDr33RtSbQBaIWanoj51psutpytY=;
        b=T4gixqfm/2W33tJM2RpyCvLSFpktXr+PfWOsf8CI/3WNUVnJtJsa7m3IL4hR3+9Dcy
         sC0s/mdZt6qnUJOW4A697T9FQI90A1krqn0TrHGkD9NVmmpd3ty5FW8AGJslEXnOUX03
         gLeugLUYomxttORashIyYjX3QxQ+bA9V65af3EseV5z4UW66hwTi53jotAWbnWPiZKA0
         kNJSrziHtWsbIMbYBT6OutXV2rJVb9IH0GG4Iynccx4gOCd4Cwxd9H4eYsUjfT068qCZ
         LIYHq5yftBtartEajBdwJeXwuoj5TtyBU0GlkmAxIRG9ADWPyPk8yd2nTuFyjNQi+tvR
         zkKg==
X-Forwarded-Encrypted: i=1; AJvYcCU575lFgPmBted81xUZXfBJa4XgefU9/9eYQxqJL3YqETDxhgG3oOzkDWHXXlcHAzyU0zLM87np@vger.kernel.org, AJvYcCUer3NJqdM6j9JwiiX4inOVYL2KeLiUzH2WJsNT7HKGC/YslS1/2bsfmrUkO6IU/tlOHGmMiStxgwpHwhlc@vger.kernel.org, AJvYcCXL+J0/gurKkanJnK9ixU7Mzl8k/YGsQM4eIQlhOrM3fjAmXNaxnxygVJDOxTjwybMt49HGvWsXA1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmADVXYfNeZkkJSc5I8AeNzDC5tsoj1F9T7jcHJqjsALJVirZ
	z0Q8qW5vtB4c2yD1VbDLyrxl5lZQXHwjK6BwSYaWoRchowL+rhr+n3+d
X-Gm-Gg: ASbGncuGqO4A1vWL5gm1k8g2wCJSq4YLAKfP5yYlDNzahrIFjwZG6bs9r+9xyf/4G/T
	eSmo+k9aVLbRpAXAqNWqpEmnPswI8OBCNRoIqch80uf488h5WCA8MgwGg0hgZKVlECGgtArsvru
	s3z1f7dfksDonKlGkwYTr5WX6gudWjK8zfyoRdC0YgxwpiKOT7ukV6ZyKyrs+WDD02ZYg3KYg69
	QyjIKUsvyfORxvq8fa4gzFvFwRLe071cl0tS0zTrUqWV3ck1u893BfjP3+SWPmacu0mR0VF4ssH
	gnGj0ZRMLIOB+ebRlpqOc20gUQit9WSCH98ATjz6rrwjp1ACaN2dALmvDkbE2Y1spA7Q+KiN9GM
	jE5ZwOnYHEsLtkPcLc/ebSkwRW/AW4Iw2/qO88Ho+M+M2bsNJ8wJQ
X-Google-Smtp-Source: AGHT+IGCYG6pexWrVDLMOJuhlbs7lAQKJ4a7SRLhFW234N8oy90hekqLgqNebBrdrdxE6UWCH2y2xw==
X-Received: by 2002:a17:903:98f:b0:24c:cb6b:105b with SMTP id d9443c01a7336-24ccb6b138cmr8087135ad.25.1756955839363;
        Wed, 03 Sep 2025 20:17:19 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm25284835ad.95.2025.09.03.20.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 20:17:18 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] docs: networking: can: change bcm_msg_head frames member to support flexible array
Date: Wed,  3 Sep 2025 20:17:09 -0700
Message-ID: <20250904031709.1426895-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of the 'bcm_msg_head' struct does not match how
it is defined in 'bcm.h'. Changed the frames member to a flexible array,
matching the definition in the header file.

See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
flexible-array members")

Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=217783>

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 Documentation/networking/can.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index bc1b585355f7..7650c4b5be5f 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -742,7 +742,7 @@ The broadcast manager sends responses to user space in the same form:
             struct timeval ival1, ival2;    /* count and subsequent interval */
             canid_t can_id;                 /* unique can_id for task */
             __u32 nframes;                  /* number of can_frames following */
-            struct can_frame frames[0];
+            struct can_frame frames[];
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
-- 
2.51.0


