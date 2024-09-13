Return-Path: <linux-can+bounces-1498-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99710978881
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE3A285606
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13412AAC6;
	Fri, 13 Sep 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2L3ODYp"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9407224CF
	for <linux-can@vger.kernel.org>; Fri, 13 Sep 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254476; cv=none; b=cMYh9aNWxxkrf8yO9dqDE1LSmIulrks6Ov4jtObaysqgCFmuuQpK7ok0fnot29n6uzpYKY7jPm2VfHS5kt+jgewWqT/WV7TAjbg0PkmvlfRqvVmRaKffu1Rp2YSBSkvzEtJNKBCPe+/4yEJ7b6uYBsheP5gehxImRLVRRYI68Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254476; c=relaxed/simple;
	bh=CmgE2VZ/f5X/KdbEvA0Y3Dr3y8auT8P9/7dpJD3okLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVFxza1aAETuMqR2slgwxUNyzPvbn+aln+cVuj9qof4M5Zn/12w6uO42cVmu6yxH5gpgUm+1UhAIq1xU7wSjw1KKMGpPyzfEyS3iDyvCZvk0CZAIn4qVubccizZNH026XdB9HdAuCLQJD+J4LxqsrYp+FlyFziMERzueS1ebm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2L3ODYp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso2866871a12.0
        for <linux-can@vger.kernel.org>; Fri, 13 Sep 2024 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726254473; x=1726859273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmgE2VZ/f5X/KdbEvA0Y3Dr3y8auT8P9/7dpJD3okLo=;
        b=Q2L3ODYptkRWZhBIdxmXkOyfSQWWKg6EtZD8eUuF9NuMey5U7EhGnp11pYVmCRxC/O
         Epa3i3YaMJ/w1Y3k1wBPLzTN7085Tp8jMKPP3C/uAezC2lHqaDiaT70PfAKzNU3DbTR4
         sY6dPK7azS0pWFBliDb4UyzyjXUOOFF2gjggLzWdJhXDv5vg1RROLnUN6ihXutkGch5a
         VJti0cdHAZPSKQT2y1vDhNdMyiqMY1JKo8q3BTvwqqX8bVtW9VLS2+vAJsRyi3FHbouT
         1avrgIUZlem6PNHEQEiybdcFLgLKXsQ6bOF05DrdlFLK7VKch0agvvC0C2r15KVQbfWz
         3Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254473; x=1726859273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmgE2VZ/f5X/KdbEvA0Y3Dr3y8auT8P9/7dpJD3okLo=;
        b=ejQgfr9QO/9c9o89SGwzpRGs1wirDW1l5Eu5nk0kQwAtRZdyc52FNJtAUnxKdzjr/B
         THmR5tzhA68GGmfgnWg+LQdAjKH69wNNUiVRrlNuQoPzIQnufWD7Z2PpdFHkaC/VoTpD
         SUY5e1veSNB95QEXyx0+pzBFNyj9vtkVRyYb8BcP4yVdCNZDrNyrlkKsN6ktu2wPyFNE
         84hMnpYwM1gDUQFapTxsI6Br3Ay/1GcZ2J4hCir0Fmi9vIC3RTeqBOEqBwfdJgTPPrqq
         tRo0mWWlDt6epFAj/pNhN8/RiJY3RDx6utGuJjESmxmVRxGD1EsiHc2GVXduFl/83fyC
         hKFA==
X-Gm-Message-State: AOJu0YzzkE2b6hTtbKXYK0eLLpqc53Cl59no7foo549b9BMI6HMHTQdf
	inuLAHMkemBQY7gclxGjyGs0nB2jCBj/iuQOVdUlH2LuarhswtdN0eXQqurosgY=
X-Google-Smtp-Source: AGHT+IHXT6+Yv4cTWJ4hkh1tazJQN2J0nfklRmeo1CmRU1qhGq+qPZfZioZqB9wmY0qeEHdE4gvPbw==
X-Received: by 2002:a05:6402:17c4:b0:5be:e01c:6b5f with SMTP id 4fb4d7f45d1cf-5c413e541c8mr4890467a12.33.1726254473219;
        Fri, 13 Sep 2024 12:07:53 -0700 (PDT)
Received: from nuke-vm-u22.fritz.box ([2a02:8071:8284:5500:4503:6c8:1ec3:5d3e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76f27sm7833218a12.66.2024.09.13.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:07:52 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	max@schneidersoft.net,
	Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Subject: Subject: Second version of the patch is ready for review
Date: Fri, 13 Sep 2024 21:06:26 +0200
Message-ID: <20240913190709.129713-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all reviewers. Thank you a lot for a great review, your time and outstanding imporovements suggestions.
I've updated my patch and tried to follow all your suggesed changes as good as I can. Please take a look on the second version of the patch.
As I already told - this is my first time working with linux kernel mailing lists, thus I may do stuff different way than expected.
Thus please let me know, if I still have to change something.
Thank you.

