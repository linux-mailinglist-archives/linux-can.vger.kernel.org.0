Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11CE27AC65
	for <lists+linux-can@lfdr.de>; Mon, 28 Sep 2020 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1LEH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Sep 2020 07:04:07 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12326 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1LEG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Sep 2020 07:04:06 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 07:04:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601291045; x=1632827045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2e+YiTkPJF2MRIohkUpVbfm/pnOYP2RhfiN7GNngVo=;
  b=KCmOrzsDvEEvrmBmWAS7EMyPqEUwmrEDn7welkSNQ5b7aoLPQLi6202z
   Om/N5GMr5WcdNC66612+8SODjQnmZmwAY4xsk5GV0kku/xfrXOlcFVzxV
   yqZHR9BlacGKNDm77Xv09e0c5iKKdblC0hhQMcLptSpAJYYd+jgZg9aNE
   0hKaiseNKZVc1YY0y46ZbMdcYTA5QTKYgoVWNFKf54q+hJoAEmyw07f7f
   tyhC7MDcxh4m9hGiyBO+BPa2kHrGnKl0Y6wf/9IEVMZyCEawqaVSPWzZA
   499erlII6dzpGj65lu7N9MMeZ4TvbHP4apHie1Hi4NuTchnyDf3zxrV5s
   A==;
IronPort-SDR: mRCcH9JS7pdNG0AxahrUunWhz8dq84/8N/evYxu1hm9/hAWyk8hw9+oGzjlOBu83sjR4MMJvVA
 DlR8VLZNeqgMoXa2IIo22DMn4JGR82NH3IMCKWAf6wICgnx9/VpQSt0kHm6VOSeGCCCHwa/TSz
 Uli6YYJFcWkHVHTENDgKtv4ELDGqOoCVuzKa5ro2PpEvo2r9hG+LD50Fp9zuiyHK4otPdJC6ul
 Rw9jsB9Q6j66n8W+s0ZWAPtXZg9pJhD0QiglgdhOds60OmjVYxykxqsoQpXqDByLUJps1AxDOb
 eqo=
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="90627933"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2020 03:56:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 03:56:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 28 Sep 2020 03:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4NPHtZMi3xUcxAo1H81LrnulKBiJeBaDZXVUttgg5mV1K+PZ/u7xpwhqhzUJqjev6kcfm76UwtRlD1rRClXogBr6ZwOhsSpwbzOLsOAnQ5deyrh5Y5rMDck4cvmE9FjTI6rJ7Wh2zpTov80HHazZl0A6lY0p+0dkYej4RXEkCVaM0B2LPHKPfcMFH08JBP1u2vtcsJX/yon5vpf6wedsvGAKJ181RCTiaMnW9x3xkXa+FJd2arUgOc8vAMIYqKG9xG/6ibUD0YCt2V93g9Uz7OakiAL4u1yWsnQOzt3lp32TlpWw90SWpNQOjIf+YXb2YgjNoZz34Xrb3Kcq+W5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2e+YiTkPJF2MRIohkUpVbfm/pnOYP2RhfiN7GNngVo=;
 b=mHPp91ZU2XujdPNjXjs1alIzHsj4eSnLYucb9+yaH54eR6gI303ZPxHWZ2eSjd3wgbOe7HQm0hihORoMX/7suUjzX7LxyPAQhwRhuaghvyu74gRJ2AKYO4CAMojePZD4Ckfxntv56q/dnsIqneXan0V0f6stqVCDPw/8z76zn8BE21y7Ogy1pj30c2EZA7mRVPTDBks1PMcUlWhIkZiVeQABwHOhQ6+e6S1Vx7LO39M6+fbvo5OC8IdlKJ0gyyEiOls0QeJaiIkjI0PJyuYE5AGmPDdmtGSqxmsRV0U84MOE66FSpvMfcW8aqYYLynK9YweDuhuzrQrF4XcFTuY/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2e+YiTkPJF2MRIohkUpVbfm/pnOYP2RhfiN7GNngVo=;
 b=XqXd7I2Y3Qv9/AdvbFDbwHTi7f+UyW/EPtEhN5DU4yjZtZGdN94eg8/JJnHI7mANAtbrMUhwdktkQYF6BvCPEGZUyCMDQ638aLUfjMVpOsDiGQbhBz2StabaXRy9M/E8bZNXBjSQzbQfhHH9t2VUpyEaodB6QcxfPowKf4zf4JM=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 28 Sep
 2020 10:56:55 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603%5]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:56:55 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH] can: mcp25xxfd: Add explanation for SPI clk limit,
 Reference to ECC errata
Thread-Topic: [PATCH] can: mcp25xxfd: Add explanation for SPI clk limit,
 Reference to ECC errata
Thread-Index: AQHWkwj7o4SN1UwKRUqYvRRTxdERNKl92oeAgAALjOA=
Date:   Mon, 28 Sep 2020 10:56:55 +0000
Message-ID: <DM6PR11MB42839BCC0CA1C4D8AC4BC4D0FB350@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20200925065606.358-1-thomas.kopp@microchip.com>
 <05c1b338-0d98-c2bd-9f44-5d35661ce773@pengutronix.de>
In-Reply-To: <05c1b338-0d98-c2bd-9f44-5d35661ce773@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3b80995-c364-4b45-4899-08d8639d3712
x-ms-traffictypediagnostic: DM6PR11MB4075:
x-microsoft-antispam-prvs: <DM6PR11MB40758544C0B676DBD2ECCB3CFB350@DM6PR11MB4075.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kO4AhQqqcAidwYv1cs2HhxCD5E63vC/TkWWhwMO9i84BvrNGV9xho5mVzHx73nEB4pXdPJVHFTJjTD9PublMNqOAOhDCzT+US6nnZOhaBRSXesenjGhwKyACTtfsj2FYLSktt2gRwC+ebp7glKIKxLwyTH9gpQSwc24ETxSz7HWFVuGq4a5Swz+7/0KT5D2iVjlHnWHuCcHp/8YocMtjBKBF5HOoKjErRlM8CXtYzOvxl1zo1ZxHi2jcz9a1uPQjdqgriKg8+OqljWAUs5SgBDtnsps3kfEi/A1Ex/v3UDz5ssDcguxSCMOmjtd/MRPMJzlKzOxWkURKEqDJF2ol2oQCY93hwHekQ2obPfj2rem4nP4PkxyiQvaC1OIJxdiiTzWS6dXXY6QWy9jHHeBETGILiIl5JguwnNYidVBie0xhJWekoAbB+fpAPUAtuuUtEvZiZMftL9NXy+nZY+Pzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(8936002)(316002)(5660300002)(7696005)(478600001)(83380400001)(4326008)(110136005)(966005)(71200400001)(8676002)(26005)(2906002)(558084003)(86362001)(186003)(9686003)(66446008)(64756008)(66556008)(66476007)(55016002)(52536014)(66946007)(6506007)(33656002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /OQWbpLoIxvOHRm5Q9xJOMgwXS0gF9FUwhuRpWHUpWqYZwg8SiIPsnA8vSI4Mv+hRggN/iDCPtCmKWKu3lkfFP5Cv5bR9qZtuVy1faKcZtRrWYWPmtdFzhx3M5a02ZvJEdwM9b9Noid40wy+EH5dn+oVcntnf2RO4Pt6xScgEmavBz1W0J8lTUdgc511q88OKeej5Pp++zql+OtZpxZgIxYachM0Qw7EAma1wMsOfxFAlbauVynp5r2/wArtpcNBrHHvqzmQU9zzXpGVcPwHudEVW63FWTJxdEWQvSkjffP1XtPrcL24tsnKJvJc/OcUXqrWCzY+zTaMeSSm92yStkTcg7Sws+2DykCSLlsGBVvAjnbRkSz/a0lDRivMrE4vPx7rVPXN1Oay2Jv1dlvw1jS0c2nrknrev+5YyGHNsj5dqpaVSYgsD6IGRAdXkZIlc/wIrUSeiMZRK/nrbT7BkxEe2czILtbtM0G+UQdbVmH5KKl5LOK804hiZIuXvXKZwvm0l7Gl/wiTsciDirtgZ95BABbpCjW6fAkFQ42lc5TkJcqgbjAcO56ikJUleYsEvyvF+De5AS+8/tjarn8+mPV0eYPWaznHLMPw20CQDtzH/4qxdExL3FN+T0TxpEdzf9vSkCDKsh/+0Js6jTDbvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b80995-c364-4b45-4899-08d8639d3712
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:56:55.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpurUXnfXhamDGb+ehgmxyuZKunnqW4C7e7aPNPJ1ENjmwjcOafBSbPKf0Ub5nS6cgxq6KtCrAVEqIbJPY2yjrHbA+uHF2zgBSqBD9i1PCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBUaGUgIkRTODAwMDA3OTJDIiBpcyB0aGUgbmV3IGVycmF0dW0gZm9yIHRoZSBtY3AyNTE3ZmQ/
IElzIGl0IGFscmVhZHkNCj4gb25saW5lLA0KPiB0aGUgaHR0cHM6Ly93d3cubWljcm9jaGlwLmNv
bS93d3dwcm9kdWN0cy9lbi9NQ1AyNTE3RkQgc3RpbGwgbGlzdHMNCj4gdGhlICJCIiB2YXJpYW50
Lg0KDQpDb3JyZWN0LCB0aGF0J3MgdGhlIG5ldyByZXZpc2lvbi4gVGhlcmUgd2FzIGEgZGVsYXkg
aW4gdGhlIHNpZ25vZmYgcHJvY2Vzcy4gDQpJdCBzaG91bGQgZ28gb25saW5lIHRvbW9ycm93Lg0K
DQpUaG9tYXMNCg==
