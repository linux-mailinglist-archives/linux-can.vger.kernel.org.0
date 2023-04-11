Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9E6DDCDF
	for <lists+linux-can@lfdr.de>; Tue, 11 Apr 2023 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDKN4H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Apr 2023 09:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDKN4G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Apr 2023 09:56:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0716172D
        for <linux-can@vger.kernel.org>; Tue, 11 Apr 2023 06:56:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51396f3e6b0so499349a12.1
        for <linux-can@vger.kernel.org>; Tue, 11 Apr 2023 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681221365; x=1683813365;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=nchd1OZwFL+03ZnRjEqFTtbR94SJnKMxLP7kIfcnjRqLPxhoPQNcXI5LK2+tOj3ZuY
         Cr0aoqRIybmfGNDT04BmA0l4qWOQ9HAiOhShiY0vAdscAxGzbZq5GE+7E7bd1oC6+vGp
         xBD9DAxcEoJrwMnOgZxAThdFxz9GFeGDfVspd1zNhVMACx2kdyctIE0nPIoA0C/HTvgm
         lj8oUISJLVaSXYQjwS2GAAvpyBOPHhOcxTmhOPWvy9Q2xTt5tQRnDfJu1uzivWLvh8BX
         iLcdaIZ7bB0qWNlwx1yvqaWY6agsGxEKbWVl6KwpqmoCdRfBDcg3Mjkc7254RrKkEbKs
         WV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221365; x=1683813365;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=O1LwavRAaNJoQ1e87tkzAfs2Pg4zu/fMX8v8P16qmeZs4Ub0GcLqkCu8R2j3YJt5My
         4bvYwjs6PIhn5SVoQ3jPCGGdqH9DiBLcPX4zxbwXgD5e/gR4kk9ezlr3gAG1fSkgVGsf
         YwNiOHdahymemTr9Opc/BvTaFP7BJ6GqBS/jWl79rEv2VyFQA4HYE6ITqYePZnBCA5W+
         /+GrGjBREXz1m+r9vWGjfemnztghiH8LqDJIfftqaQwrJwGpXbPYAS0nFL5JGRrTO3jH
         eXzWtwy90gZbdw9OjgvNhveHmo1F7pOCeVZ46GYapWyY87hdF7Pqh/6kOlqJ+026E+s+
         kOiQ==
X-Gm-Message-State: AAQBX9cWBM8kWnEaQO3zsk2WF/T3qjDnW7oxaGdFcAg6zvinHDAdVAeo
        VQaJsjEGerS3z82wMhodH0ZurdHgu6A2ZwdazUU=
X-Google-Smtp-Source: AKy350Yf7s0MeuU3hBLnKREbkAfnt8/8+sI35pPLqrJtk4+BtR0+GXNWQAOYS1Em/MUTRtG73IHu/lFhIgG5fwBfn/I=
X-Received: by 2002:a05:6a00:2185:b0:625:644c:65f2 with SMTP id
 h5-20020a056a00218500b00625644c65f2mr5189866pfi.3.1681221365429; Tue, 11 Apr
 2023 06:56:05 -0700 (PDT)
MIME-Version: 1.0
Sender: awiloloab@gmail.com
Received: by 2002:a05:6a10:afce:b0:44d:6b91:22eb with HTTP; Tue, 11 Apr 2023
 06:56:05 -0700 (PDT)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Tue, 11 Apr 2023 13:56:05 +0000
X-Google-Sender-Auth: mnR_aiq73-Jn6cfIPxHj6_JBu6s
Message-ID: <CAOFxg+OoqxzhMn9Lk1vKQUQEwx9hu1sGYdSix6FAycSgyEF=Ww@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello!, Please did you get the previous message? thank you
