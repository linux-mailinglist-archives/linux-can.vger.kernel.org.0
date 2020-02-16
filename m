Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914E160431
	for <lists+linux-can@lfdr.de>; Sun, 16 Feb 2020 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgBPNnZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Feb 2020 08:43:25 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38742 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPNnZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Feb 2020 08:43:25 -0500
Received: by mail-qk1-f178.google.com with SMTP id z19so13758928qkj.5
        for <linux-can@vger.kernel.org>; Sun, 16 Feb 2020 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=wuEJisfLxql3Q9aqnsOoAORo2hC4HCFzM3gz/FNW2uY=;
        b=B6L8WUsL8eu9z6ZNl5q0a7RHPieh9TWIZZBxv6a1Ae76TBEn6JCErteiXTEufinUwS
         8OApHR0SkQIxg1w8gvXA1hv7t/XFxqAdAyUDd6MA6Ogg2nUsOOWEKiFQswB/FPSODPQQ
         3qQ7Hr/KvV4KLChHm0YJ5jJ2A0+o07EYVOLSigCSSOUCpA7XBaebRZMr5OqOifrPGem7
         ZStdLgcEyCDIgzU3TVVkT5A3WLRpmLBULDCFZHodVyzcdggySVEySVtGmjjnfALy8DD0
         39Zvr7fu01Gu8Qo6ksY+e5CLcSjOyUiQRN8MTMfpryX+GIElOPG4IXRsKy22wTq5+cQR
         w1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=wuEJisfLxql3Q9aqnsOoAORo2hC4HCFzM3gz/FNW2uY=;
        b=nvfvywj1uB9NdbcSj/4z0bd3ZxoGT5zDvnAM04Lyv9DfZ9nJts6NL66QxPdorbiFju
         dHWmMlD0a4sgtEfMMBOGgnEt2EJ7c7Lu1Au5Kt8sU6XkFecS3FWHYyrU9X9A9OwCRhYC
         GDjUsgDOctU01HvR4rXgGQJgx6fG+w+UINevWA7o5FpFlV/Dn+8O9+0DYfCnFbSXaKOt
         vdqfCLEubJosYmfiv7Z0BWGzeaH2AJbIBKyUoq8HDCGuz8O8HMdi4K6CfPIyw1bHgR19
         wqByKioHs92tP1Wd3GlHyEBuPjJVbj18s/rdv/Dhvt9MNMMaX5tPFKCgEn9qdWmBpYT1
         XzJg==
X-Gm-Message-State: APjAAAUtT3lpYeFu/XP18w7rbtGqPmYUSjFjWMRfzSA+FDyDIbpMl+UR
        63JMRh6h2oqEUyuT4L2mm47XaBL0JmQ=
X-Google-Smtp-Source: APXvYqws+Wu+CtoKmyncisqFQIeSUheJhISyO0l27yT5wyId1qRjlQubDouSxZbL8b7ha46KwtyVNQ==
X-Received: by 2002:a05:620a:545:: with SMTP id o5mr10131037qko.27.1581860604376;
        Sun, 16 Feb 2020 05:43:24 -0800 (PST)
Received: from ?IPv6:2601:18c:600:dc42:7d5e:e4de:7ed8:d90b? ([2601:18c:600:dc42:7d5e:e4de:7ed8:d90b])
        by smtp.gmail.com with ESMTPSA id a2sm4884280qka.75.2020.02.16.05.43.23
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 05:43:23 -0800 (PST)
From:   Chris Morgan <chmorgan@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: canfd through slcan via SocketCAN
Message-Id: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
Date:   Sun, 16 Feb 2020 08:43:22 -0500
To:     linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello.

I=E2=80=99m looking at options to add canfd support to embedded =
processors via serial using slcan. I=E2=80=99d like the devices to be =
available via socketcan. Looking at the slcan driver it looks like the =
MTU is something around 30 bytes and there isn=E2=80=99t any mention of =
canfd in the driver or in the userspace utilities. Am I missing =
something with this support? If slcan doesn=E2=80=99t support canfd yet =
is anyone working to add any?

Regards,
Chris

