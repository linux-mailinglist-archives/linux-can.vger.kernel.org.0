Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD11F6B47
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2020 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgFKPnn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Jun 2020 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPnm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jun 2020 11:43:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FFC08C5C1
        for <linux-can@vger.kernel.org>; Thu, 11 Jun 2020 08:43:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gl26so6908193ejb.11
        for <linux-can@vger.kernel.org>; Thu, 11 Jun 2020 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nrL6gp0yYKtPdP1RyMr/XEgQQ+PbLuszPv0YF9qUW1k=;
        b=doF+GcT7ia36Q4rj1oGncBy8RgfXyNGlzHI6c1WmzbqQbp3wrkeiezrrN4ygTLjEHC
         kwr6lK1PPypSK0BSP59x2kMjFa+LJw6u5YOuhZrxneIsn73HN4blVeaRcICkuz3xI216
         qgBjq7YOpEh8dprb07wTZktLdpN6g1uxRBFvaqXtWhw4Satfd6iu3x5urTxZ8iolH1ZV
         38fTmb+hft3lZtDkb+MNo6DDFTPvYgBU/luj65XBsnDz0wyJt9cRpuMtE2WV2+LSx668
         msFP8kd2reKp80S5AKCVXyjQ0XwbajuSPOm08VYH36km0sm6hEDD9aPtXdhhQYGiLbKh
         5i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nrL6gp0yYKtPdP1RyMr/XEgQQ+PbLuszPv0YF9qUW1k=;
        b=uMEXLljXO8chUutoZkogw7nmWtFMUtJHqGT1oy6TsNycVUI+5uwIIogJM5paP84E1E
         JPi4Af3hAU6Jz1QS8cSRG8PQtOOZHa70gpso+aAlffvTd3DbuCzUotWuz+2w3PC8gqHf
         8tWGNJFoUUpGI0Cy+7I+74yLxmVbbWOkg7ZocslorSVEXxe4m9tm84A6TZDu01E4/1Su
         7QDPDd9QvD5gjISKWrvDP5RQCKnfb+88RTO/cYgpERGqqekwlBTg0OmiTQ0/NjDh13X+
         TT7c13HEyXCZY+ImzWcgMkfGLjyeUZgxvRcoa0l3JLuefltc97XeNb7V8F7KeFJGsVRw
         hWmA==
X-Gm-Message-State: AOAM531UsDAP0c8ZDALhc/LCzLlcblb5wxrZ2n4GfUXuk9HQIlMR5QMJ
        AwL6DKMh9o835R9A5PhFHElolgtsOKahgPTm
X-Google-Smtp-Source: ABdhPJz12ujYXz5Ln8PjQUwnnZYJDVnFLmUpU5awY+1r4N3xBLZAxNqcMbXzPcN1aKgQoZvmtlLuDg==
X-Received: by 2002:a17:906:c9d6:: with SMTP id hk22mr8630440ejb.101.1591890220191;
        Thu, 11 Jun 2020 08:43:40 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id cn14sm1707922edb.22.2020.06.11.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:43:39 -0700 (PDT)
Date:   Thu, 11 Jun 2020 17:43:37 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: isotp in mainline?
Message-ID: <20200611154337.GA3166627@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

Hope you are doing well.

I'm reviewing patches we add to our beaglebone kernel build [0] and
remembered that we added isotp for the Macchina P1 adapter [1].

Is there a current effort to get the isotp driver accepted into mainline?

Thanks,
Drew

[0] https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-5.4.y/patches/can_isotp
[1] https://www.macchina.cc/catalog/p1-boards/p1-under-dash

