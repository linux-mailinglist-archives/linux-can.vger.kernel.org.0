Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6218B1C3
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2020 11:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSKxz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Mar 2020 06:53:55 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:6142
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726188AbgCSKxz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Mar 2020 06:53:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAlIWFwNlHk+J49LhXpjpoZvMRbvkLHkB909TKH9Yjw22JULRe6GGICh1N+uQD1yW+KjLyDZ4AzeFq/p3pD8GMJGUzll6cmwiFR6sme07i3XYJi9RYso8+2wFgeZVLJWaXWYM80ZLKfzU5mD9llfBnql2T6EO4zAFt4IMR/0kKJfdo2a17u0wDiwCZpYrFKcTKlp/Ee/AcQVScFFcZnrjyvHTPZIpRBJk6N5+ukXKhLVFMkGEmn8pUepw3Cvr+I6n/5mwLTtVvDzWbjg/rXRjqMkF6VONiPHTZSnKOurP8y1hf3cV5RnEhTRU5slBN+YfZ4xvq1zOOgyozmkUHaWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFHKkJjq8lC5rPNaqX1t97679Hr5uFvQlAygSAUz7Eo=;
 b=breqKGIubrVpvmBDcMVkgOaVlGiXHkAvh1lYzymE0M6CTTSnbTAc9Qdd65AsraoC+epsqPMQm+1OBUj1qU3HfzSK0Q0uyGn1r3qJjUlvfr9VlhEdDHeUF69Evsz+/0GXkS3Wr7P61/POryQC++O3VyN+1wECk+XJY/ttIoP4CxxK63qlaarv9+rVtapqL4d4GMvFi55fGP9FmAiv7HlWjUba3+Ib1ma/nOc5TJCbJtTL6DeASbCcbcwy/xjUkhahE7g7V/+Z/nsSRRTHTX5DnQdqUTbXUQ6NmmTiFxw2nPflW6sQNgHnPMRZnEt0zyuo6K25FWgLPrkyOcfAMVi8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFHKkJjq8lC5rPNaqX1t97679Hr5uFvQlAygSAUz7Eo=;
 b=lSeuYCEExSYsGdNhmMjUYUT+tVP0QGfnvyvDaBE2xHgWVOjoUAOUQym17pmWcItwpJDCPFoSAZryKZ415qLCBBDQguhuDYPNKpHqFsi3CVR5lDFou1mRc/HIgNRCd19MNGR4sfEJxFHwIucferaZGjq5+00gYmdxICcxi5L/MU4=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (10.165.163.10) by
 DB6PR03MB2902.eurprd03.prod.outlook.com (10.165.140.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 10:53:52 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1%6]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 10:53:51 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: PCI/PCIe cards and MSI support
Thread-Topic: PCI/PCIe cards and MSI support
Thread-Index: AQHV/do29lzRw5ZU0EO1t7ZGglOftA==
Date:   Thu, 19 Mar 2020 10:53:51 +0000
Message-ID: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4bb61c2-423a-4ecd-e09f-08d7cbf3cfca
x-ms-traffictypediagnostic: DB6PR03MB2902:
x-microsoft-antispam-prvs: <DB6PR03MB290246D7C0C5C82EDE6992AAD6F40@DB6PR03MB2902.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39840400004)(136003)(346002)(199004)(64756008)(316002)(8676002)(66946007)(86362001)(81166006)(33656002)(81156014)(6916009)(4744005)(55016002)(2906002)(15974865002)(76116006)(52536014)(5660300002)(66476007)(66556008)(66574012)(7696005)(26005)(71200400001)(6506007)(508600001)(186003)(8936002)(9686003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR03MB2902;H:DB6PR03MB3093.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9zPnIjB7NYfNZ871hdQGGsvAwUCGvdrgsSZxJxN+PFoDnI+sa/3FX/4RJtm+b5Gkzsb9BH92sO6MkJ8U+BvFCToi/hBcssj81etxGTQjIXO2o+1UZO46TWWJK/XZhp8YRkK5cXzo9lV4RPYO7xcG2pOzkF4Ax4fyXWCSQmvzEUJ5u7qWKQRMOZ3TQaVvvlb5xnY3M5P9EevD8jDI00lyERDwz9T1mcDU0BH10kRim/e+6ymBC6IMX/eUhwSgbCFH7ZF4OYMU9je9IHbXNlQ5XD/csveJ3E4Zd9q93qcRbl+mfW7FCZ80V+q/o36IHaiafKxPp1ApI1C3lH7Bgv85vPGgvw6mqz6DqvuChBQkYuf5dT3dQrbIaT2+jD5Ps3N18oO54pVEgMyy4egZE1eouVNJR4Bn06re/jYBAv+rPoWpO1ZPiNKLTn+3o+5omHpC
x-ms-exchange-antispam-messagedata: kUpu7Y8Mu5fuDceHZxVrGJSZBZBv7Tc0k+pq0g45tZHDXcrLDzxfEgD/rza7KlIb0F/xEoO3PmlDTBWXMaxOub0ECcYe/LwOqQby6KyUui7PS1pji0FCy2mSydOMVvGRC6maIT5F8crtJabgawpUXA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bb61c2-423a-4ecd-e09f-08d7cbf3cfca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 10:53:51.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYg5JQBizeGmvqYACQ4fct9n21+xCOdoli2Om2UCjvQ7nRl/VTwSNGjvK1dVvN+EV1cj+LUj4KNUc9MNibVKJ/DhUXbXZGnSZbl419vYuSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2902
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello everyone,

I hope everyone is well and that the health of your loved ones is just as g=
ood.

I just want to know if the rule applied in the socket-can layer that a driv=
er calls request_irq() (resp. free_irq()) only when the interface is set UP=
 (resp. DOWN) is an unchangeable rule, or if the driver can decide to reque=
st (resp. free) IRQs when loading (resp. unloading) the module?

Note that this rule currently prevents us from easily implementing MSI supp=
ort in our PCI/PCIe drivers.

Best regards,

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
