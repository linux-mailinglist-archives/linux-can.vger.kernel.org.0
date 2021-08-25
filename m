Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9C3F7C5F
	for <lists+linux-can@lfdr.de>; Wed, 25 Aug 2021 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhHYSpE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Aug 2021 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbhHYSpD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Aug 2021 14:45:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CA2C061757
        for <linux-can@vger.kernel.org>; Wed, 25 Aug 2021 11:44:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a25so474917ejv.6
        for <linux-can@vger.kernel.org>; Wed, 25 Aug 2021 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arcolaenergy-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=L9qWcMSyPY2p51Cm3uhjfSx2IF3EHnV06Scvi6owNmc=;
        b=MZtndjC6g5kHRZ5IFlLL2z0wvcjSykyQj2TiDz5Gp8eijSA921R+ANCtwAEgv+h+S4
         81Y/n1Pzn46F+6LMIPnHCTQQ/NMcrJM00xyM+uWjCQKUB5o0C8HPx7q7ot3gBzwjIFGV
         DWkXzfqTe9N1UkGfJ7fh0Qe7Gagxny3qUzAv4RSME7PgeXjfR5YxaZYyIUYcvn6L4x0Y
         sqmxEPtqxsD+sV+XSXd49nlcgndwL4wszUAawZuXKe3J511x0wvaQrNWa3r+HfUbS8su
         LMse7cIlyKo8GRBbK19Xfw/0eBKkswzRQcdDU16HWWF+NdtgsPcJIGR0kMaeT9ButRgC
         FWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L9qWcMSyPY2p51Cm3uhjfSx2IF3EHnV06Scvi6owNmc=;
        b=bzqmc3q+sfScJAiRRS7kgceOfLsiTQsSbknuRUe/6k5J2nwPaxXQyGWoEnPh62idha
         2hukOia7BFnaIu7aqYblRF4N6onHeQgYpW71SowipjEew/Auc04MjwGVJs1gHilWHVuO
         xBcSKWiF/p1/wReI2irdTDvHP0ulOPePPYqy1UWdplL0nG1UOn8T2OY0xbyx6lQ3LIS8
         cWDqslgbNXFqfkx/3IBygyTRY/RlhagzALgzYlhOjP1OWZL+Hfpl5eu2/3XuGB5NnlRS
         XLOozlHaN9an7fkk28hjSHtl20/79CvSZIWwVEUiflntaXjTPlyO6aE0KfmZTC3CUBf7
         emlg==
X-Gm-Message-State: AOAM531BkP5VHuwho6PvfWXz1oftTO70T7BerST3/7VWKeGtJLF4cQxH
        s8qNNNX7xyfzwUTls1XfAqJheCf4HCbCuL9Qp33kOWK/QesMZLQjr3QGzOFLpgJS7LenNUpfi8J
        u2YzXFTKa9Yr7sOdpmtTASJ8WxNFEgFoFT8Wk4w==
X-Google-Smtp-Source: ABdhPJwff3bOzQi98yn9aQhUYiDM/Udfv/53fRgxMyVF3nUSzdH2zCJJZJOrHbCHNuFEufN7u8dZID7kyogSas/Cfg4=
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr84877ejc.196.1629917056129;
 Wed, 25 Aug 2021 11:44:16 -0700 (PDT)
MIME-Version: 1.0
From:   Jasper Wallace <jasper@arcolaenergy.com>
Date:   Wed, 25 Aug 2021 19:44:05 +0100
Message-ID: <CAPvzSFeGLtH-fz8mdSZL3UfajeoegvRL6cNuTdru6HnYH2=Hfw@mail.gmail.com>
Subject: Renaming can devices interfaces names with udev
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I'm going to be using a number of the Korlan/8devices usb2can
interfaces and I want to make sure they have persistent interface
names. Thankfully they all have unique serial numbers that are printed
on the devices so I can match a physical device with a linux interface
name.

In theory I should be able to do something like add a file at
/etc/udev/rules.d/10-usb2can.rules containing something like:

SUBSYSTEM=="net", ACTION=="add", ATTR{ID_VENDOR_ENC}=="8Devices",
ATTR{ID_MODEL}=="USB2CAN_converter", NAME="can$attr{ID_SERIAL_SHORT}"

But I've not been able to get anything to work.

Has anyone been able to get something like this to work?

I'm on Debian Buster.

Thanks,

Jasper

-- 
Your hydrogen & fuel cell partner
Arcola Energy Ltd, 24 Ashwin Street, 
London E8 3DL. www.arcolaenergy.com <https://www.arcolaenergy.com/> / +44 
20 7503 1386
Registered in England and Wales, Company Number 7257863, VAT 
Number 110085273. Copyright 2020. Confidential and Proprietary. Not to be 
disseminated or copied in full or in part.
