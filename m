Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3656058D486
	for <lists+linux-can@lfdr.de>; Tue,  9 Aug 2022 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiHIH21 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Aug 2022 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiHIH2Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2022 03:28:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706CA20F62
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 00:28:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v7so12155132ljj.4
        for <linux-can@vger.kernel.org>; Tue, 09 Aug 2022 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ze1eT5Lg5bNGve/aGYosnnSf8uaPmjR59Sgjcewn6dA=;
        b=Q63u1LZ7SsI6nSiYjm5CY8jn2o/GibNe1Isu6aHJmFZRkYk9jUhYjbchztvMp0LgGF
         ts+EGTUKEZQti8Hg6DskmvERKSDRZ2DbgJr5miTdDQ04UlHzUppT5QMMrObgKlK8nomv
         /J9PoLKA4lOTjfOpyEAKIbofWrjAXc8AN6X5ILm0S44HDCQh2sk8RhqVdROBvOITvPj4
         8xsMJjq2+U14rA8yaJAQgmn8ngSZWltTXZ0lOI5/NR1izoNn8s4Vn8qb9xHwnN8U/lQp
         FS+8pL/gsHwa4eQ9yvb3nM5w05YtHWLs+W1B0Ka8P1d9vB5d0n3id2lBNhfaLspb6nSb
         MQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ze1eT5Lg5bNGve/aGYosnnSf8uaPmjR59Sgjcewn6dA=;
        b=ioe40r+usgaoTI5NAdAGurwe/IzVuwZM9LSEpDbgiaEhhgrPXzJX1jsdikovK1r/Ic
         s2GeDL4eo1httVJlKQRAWkToPXhCH8SDj4n8hSHYPEWM39gNa/IFRgY3W3KhP4mQlNpH
         lILqQmwPj1wgVFeqnsHeOFGDCR2vXh+C+I7QU1cGmRUtf485QS3JoRTh3ZDPC9dnOLaD
         KQXfjrf1s93NI+qDb/1lVvER7UYy5w0T+4k9Aw2YwY+EgPc7NjiboXhdZqfzlDYIRcT9
         ZqndgMG1Hkw+b5XgXjW1heGvTs1e2IG6pP/XdjnUXtj1JAZYEvQKM0PsV4gYCqNpg2rt
         GIGQ==
X-Gm-Message-State: ACgBeo3410fnlfEHWbOkiEA/7nc/cn1t6pnlVqxK0pNob/1QEgOYqsbj
        Md6wb8rvAD6MRxKK/wI3Iy8k9jGO6XbB8wnL30k=
X-Google-Smtp-Source: AA6agR5SWMuV81z2hU/zyIf6xa+0ur4hIB97jdyKO+lQJxpYaZhIEYD4xKYP6Ctjjsfu7fgEB6j4uqig6YShtnYG7po=
X-Received: by 2002:a05:651c:1502:b0:25f:d9d2:f906 with SMTP id
 e2-20020a05651c150200b0025fd9d2f906mr3400477ljf.311.1660030101782; Tue, 09
 Aug 2022 00:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:b1b:0:0:0:0 with HTTP; Tue, 9 Aug 2022 00:28:21
 -0700 (PDT)
Reply-To: s.clarke@rahimglobalinc.com
From:   Sara Clarke <ivankatrumpamericanfirstdaught@gmail.com>
Date:   Tue, 9 Aug 2022 10:28:21 +0300
Message-ID: <CACbjJV8a8Vwf5-u_DrsmT0ynRPWwWv2p5=EcBkCzaU+YeeZnWA@mail.gmail.com>
Subject: Enquiries
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,
We are interested in purchasing your product, kindly furnish with us
your price list.

Best regard,
Sara Clarke,
Purchasing Manager
Rahim Consultants Office Address
17 Bridge Road East Molesey
Surrey KT8 9EU
United Kingdom
