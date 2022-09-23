Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF65E7B9A
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiIWNQ0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiIWNQZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 09:16:25 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7A13A968
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:16:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 73so962291ybn.3
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=EnaqBLF/tcwykPvT4642N5oxRq7C7bMY9gUzV0Y10t2xwj+hoVO0PN6ohcgmDhc3B8
         fiFv0Nrxcl4Z8ZQAenQ8X3+FQ+uShT7BiCROk7/CQTwbZ33JmxCyDHbIefqbaDbLp8R1
         GaVf4tFD8pe9hWDw7p2g/avzVNJWTio2Taj1XuAsHQK1P7Qiy/cviGPpi4JVtvq91yCp
         MRdum3C48w0wGCUgfiyixz8E1w+7BYaPrDq8EVRw385bQSWTLAnEKOE4fp3mBX4Bg/Xs
         LIfN+pWr2thCcs34YlW3FeDd6qXebeflzKpn6538gcwwEDOmsrqTC1Kc6WoA1u9FQDMN
         jZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=14OHDgtQABdysMBcoIU+WDLbIN+JJheUFjyRmLVi8k8otMI/RVbz8ZRgk//FVS/fNH
         f+eYEDs1xZaS+jMpWYdOVdzvFjFtPzouzGQi/WP8czRJ7rz1GYv7U3iELVLXv03cvwsa
         d7b67ms8A9SpDN5+6Eqj7uI9TsrL0RtXY98jcEUkhMsDhdxYxM/a7Jv2bDxeNpDXemPi
         +CUikloxmtu/ter1BZyPpoJ3lslXlJCCF1uUuLodn8MkddMcZ92iRMJlI8m3HWDLpXjW
         K8d06VxfBm0RQ9kwM/gwgS4NvdeQhEXFLtm3jG8kQOWyJKLgi+07T1WxCareM7ERJNJG
         ZJxA==
X-Gm-Message-State: ACrzQf1NoL2TRYylLylPSmS3YL3PLjmQlxePj6GyctpcwGqqJas5wrJB
        U/uQz/lS83NN/nKB0GpWOQRiPeaIQVL0aUBOcQU=
X-Google-Smtp-Source: AMsMyM6G6fQAmW7Cf+ZHufnNh4xfS86hsjMYd+QuuXVt+cva6T8nS1XX0LfdGAFmHL472KklO1NorVi71UCKDczOTrw=
X-Received: by 2002:a25:740a:0:b0:6b5:246a:5e13 with SMTP id
 p10-20020a25740a000000b006b5246a5e13mr7453659ybc.493.1663938983681; Fri, 23
 Sep 2022 06:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3912:b0:306:81a6:95e4 with HTTP; Fri, 23 Sep 2022
 06:16:23 -0700 (PDT)
Reply-To: thomasjoyec@yahoo.com
From:   Joyce Thomas <anthonykoffik@gmail.com>
Date:   Fri, 23 Sep 2022 06:16:23 -0700
Message-ID: <CAM2FRn2D=J0m-Dc=H=4eM+AS4+EQmOy66x4N5t+5Dut5Rad71Q@mail.gmail.com>
Subject: Good Day To You
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Dearest one,
Good day to you today and how are you doing I hope all is well with
you; please did you receive the mail I sent to you since three days
ago?  Please can you be kindly get back to me  so that I will  know if
you received the mail I sent to you or not.
Best Regards,
Ms Joyce
