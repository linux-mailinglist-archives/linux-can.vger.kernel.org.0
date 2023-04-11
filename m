Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7046DDD3F
	for <lists+linux-can@lfdr.de>; Tue, 11 Apr 2023 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDKOHD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Apr 2023 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKOHD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Apr 2023 10:07:03 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8416BC6
        for <linux-can@vger.kernel.org>; Tue, 11 Apr 2023 07:07:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r21so10345800uaf.6
        for <linux-can@vger.kernel.org>; Tue, 11 Apr 2023 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222021;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=MffSr+y1zeDDegUJkMJZ4NfgMkESwboiT+epTIahpfWTcro94srEXbkuqwpWto+mbY
         CvgQ9nrMA4X6TwiEcSw1R2sY5D7QkhPZGRQ527VR1PaefoX9vlBRKzzbBz7hYjq8OWrF
         z5u1gE0R9NpO7078SxMzSGUxfYG4aA7pg2QOsQaOujP8PzdWnfNLx3RFzRnmBukEuKz1
         nayKyEMW7VvMMjnxVfyVUl8bAlh9Uma+Usuzbg8Zfwc5eYN+EX2OC0tyTFtd9sZban1A
         EeKWRE+73N2cae1O6hlaPOT649hr5HOEKxNeq4lBHiXuJljpyXB0tPUoORThxrHimGYn
         ILMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222021;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=FyCQcfCGBLSfWEZb7QXvPjN2gIlIb7SFpix4QmBKxpFXXyjLNKS4eZAulZAaGVSt4X
         EKhKoXKDbFheUgmVyIvIw/NHKVLtDipXnLOKPY6aNc61PW1MuYmCKgmcr6AWwi7+1+UA
         ti/tA6zhgpWQHM9qjB56UlQ5b1egCrKMh7PvvOlWWU5n7YEWKiAwrbCYs8qU8P0r99J7
         GH8sU5vsgT1SAFazk9WkSPqKjtrPjna8SG8rf5uD7/AXgB7dxxaQWV82pUyvNKVbDSRS
         03FDRrvcolMngaGdB5irgd6ztjNpCwEuXgYR8DO3QZ4JxEusxknHEHU3oCX+F0/UggEo
         A3mA==
X-Gm-Message-State: AAQBX9eEJsIx95YMz4XmJPp4Hc1HYAQmHKbbVHUkIpHOUnTTnqSg0sZ8
        9ee+tz6uIowuEfeULFPVp4Z8nJ8rXq0FsdsxrN0=
X-Google-Smtp-Source: AKy350ajH2mX9ImuQVbO2yhxdOsuCu281buHICbD8Jw1+EBCo5VEvemREq3nJotubL5TkkMrHkyohCmNPMkWUpAeZkc=
X-Received: by 2002:a1f:9114:0:b0:410:4a2c:1e9a with SMTP id
 t20-20020a1f9114000000b004104a2c1e9amr6070859vkd.1.1681222021620; Tue, 11 Apr
 2023 07:07:01 -0700 (PDT)
MIME-Version: 1.0
Sender: sgtkaylla202@gmail.com
Received: by 2002:a59:c5ac:0:b0:3aa:b42a:933 with HTTP; Tue, 11 Apr 2023
 07:07:01 -0700 (PDT)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Tue, 11 Apr 2023 14:07:01 +0000
X-Google-Sender-Auth: d8a8GK8c_xRZx1oacf-MzNjPFwE
Message-ID: <CA+efZN7=cKvZRBnB_BsSgNr=oZdvXm4DaFNQ+MoFQxe7OnfaHg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello!, Please did you get the previous message? thank you
