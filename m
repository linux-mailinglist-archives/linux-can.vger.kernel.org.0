Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7D37297A
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEDLVy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEDLVh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:21:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73EC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:20:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l14so8972122wrx.5
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ15RY+AZG6bSU6393Tvc6aE64Euf3YfNVcIoSaB9RA=;
        b=zSPvS+mTxoL3NUW4x5/p+7gFH4Ib8YmhBh6qH7O17gY/3BY+4NJ4dooFg4xr4k9ryb
         6BYsXEAgHSGuYtPI33lt8Ds3A+BiGoDQFHh+5jKELRlVGrmq2LsuKPLM6qEhy4+omXBh
         mQeLhYEwwpZLfV/bL/Mw979dTgJWy5GkJbwh9Lnee+5RRUyIyg/uP5YQtrL91UAp0BFj
         R8iZZ7BrTdBHGIIhxDhZsP/tzHHqfinN9PieaOxNSlPO6bqmBSWpTyp/yWleEPUFOxKq
         SVexy19X2dNCx2a4KQkKQ0T6Q4R56cdy0z0RzSdcR4W0dGGi7y+l0DMdqLQBSfujoReI
         VXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ15RY+AZG6bSU6393Tvc6aE64Euf3YfNVcIoSaB9RA=;
        b=gKB7QC/norfNVkvZaUf+8H/7Y8LNm8FjzvtoAB2Bl9jV1ipP288GSz7gK0wxwr06Eu
         62ZhB87qbV3o1tE7kQGJU6H9XXQNoSXAocW09QDk9eVl7ywGxoOrIsStuA2+TIJx5mdY
         XsKO3qWjPNuZeMRmbiI2bZLvgJEfKrtyRNpeO6I+N1AhRCHdokA9+9crmLCmkqc5VvA7
         eird7LQGIhPUI+JywGbkvb93wMwsIyCrLSCfUE1jlKXv+OzGvTm+oCTX+9DAbic3xUSn
         y6p3oh78HGT/tuXefTN/jPQc1rHJ58uH9OTWHl90xwY24R6X5m5uMNMxzdboncoTYet2
         0B8A==
X-Gm-Message-State: AOAM533lohEQsRyPqTNsWyPZPlmVXLS/eXGi+MJkb/ra2LOLCnb6DjBG
        h6aG+jasQX0i22kZm6ZWn8WbxmMVep3oT5Ox
X-Google-Smtp-Source: ABdhPJxX/aoNiASjkR0EnZ9Q3QLAYZl1PNc65Dn53Rh6jAyptmDmA02KeVngKwURzd18e+Vxh/Rw7A==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr30928577wrj.328.1620127239776;
        Tue, 04 May 2021 04:20:39 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id a21sm2222022wmj.34.2021.05.04.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:20:39 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>
Subject: PATCH [0/4] can: m_can: various regmask-related cleanup
Date:   Tue,  4 May 2021 12:20:31 +0100
Message-Id: <20210504112035.336424-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all!

1/4 modernises m_can.c, using GENMASK for all regmasks and
FIELD_{GET,PREP,MAX} for ops. Maintainable, consistent and concise.

2/4 makes clear all the differences in CCCR between M_CAN spec revisions,
and orders the defs by revision, ascending.

3/4 makes explicit the config of RX & TX buffer sizes, making it a bit
more readable, especially against the spec.

4/4 fixes whitespace in a few comments.

Cheers!

Torin
maxiluxsystems.com


P.S. Accidentally this header email once before when trying to rewrite
it, please discard! apologies.


